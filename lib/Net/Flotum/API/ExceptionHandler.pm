package Net::Flotum::API::ExceptionHandler;
use strict;
use warnings;
use utf8;

require Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw/request_with_retries/;

sub request_with_retries {
    my (%opts)    = @_;
    my $logger    = $opts{logger};
    my $requester = $opts{requester};
    my $tries = $opts{tries} || 3;
    my $sleep = $opts{sleep} || 1;
    my $name  = $opts{name};

    my ( $obj, $req, $res );
    while ( $tries-- ) {

        my $func = $opts{method};
        $obj = eval {
            $requester->stash->$func(
                @{ $opts{params} },
                process_response => sub {
                    use DDP; p "here";
                    $res = $_[0]->{res};
                    $req = $_[0]->{req};
                },
            );
        };
        last unless $@;
        $logger->error( &log_error_txt( $@, $req, $res ) );

        # erros nao 500 desiste na hora.
        if ( $tries == 0 || $res->code != 500 ) {
            $logger->error( "Giving up $name. Reponse code " . $res->code );
            die "Can't $name right now, response code ${\$res->code}.\n";
        }
        $logger->info("trying $tries more times...");
        sleep $sleep;
    }

    return (obj => $obj, res => $res);
}

sub log_error_txt {
    my ( $err, $req, $res ) = @_;

    return "Error! $err\nREQUEST: \n" . eval { $req->as_string } . "\nRESPONSE\n" . eval { $res->as_string };
}

1;
