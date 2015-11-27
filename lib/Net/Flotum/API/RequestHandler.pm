package Net::Flotum::API::RequestHandler;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;
use Stash::REST;

use Furl;

has 'flotum_api' => ( is => 'rw', default => 'http://192.168.1.43:8988' );
has 'timeout'    => ( is => 'ro', default => 10 );

has 'stash' => ( is => 'ro', lazy => 1, builder => '_build_stash' );

sub _build_stash {
    my ($self) = @_;

    my $furl = Furl->new(
        agent   => 'Furl Net-Flotum/' . $Net::Flotum::VERSION,
        timeout => $self->timeout,
        headers => [ 'Accept-Encoding' => 'gzip' ],
    );

    my $st = Stash::REST->new(
        do_request => sub {
            my $req = shift;

            croak 'invalid flotum_api' unless $self->flotum_api =~ /^https?:\/\//;

            $req->uri( $req->uri->abs( $self->flotum_api ) );

            return $furl->request($req);

        },
        decode_response => sub {
            my $res = shift;

            return decode_json( $res->content );
        }
    );
    eval q|$st->add_trigger('process_response', sub{use DDP; p $_[1];}) | if exists $ENV{TRACE} && $ENV{TRACE};
    return $st;
}

1;
