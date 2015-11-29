package Net::Flotum::API::Customer;
use strict;
use warnings;
use utf8;
use Carp qw/croak confess/;
use Moo;
use namespace::clean;
use JSON::MaybeXS;
use Net::Flotum::API::ExceptionHandler;

has 'flotum' => ( is => 'ro', weak_ref => 1, );

sub exec_new_customer {
    my ( $self, %opts ) = @_;

    my $requester = $self->flotum->requester;
    my $logger    = $self->flotum->logger;

    my (%ret) = request_with_retries(
        logger    => $logger,
        requester => $requester,
        name      => 'create user',
        method    => 'rest_post',
        params    => [
            'customers',
            headers => [
                'Content-Type' => 'application/json',
                'X-api-key'    => $self->flotum->merchant_api_key
            ],
            code => 201,
            data => encode_json( \%opts )
        ]
    );

    return $ret{obj};

}

sub exec_load_customer {
    my ( $self, %opts ) = @_;

    my $requester = $self->flotum->requester;
    my $logger    = $self->flotum->logger;

    my ( @with_id, %params );
    push @with_id, $opts{id} if exists $opts{id} and defined $opts{id};
    $params{remote_id} = $opts{remote_id} if exists $opts{remote_id} and defined $opts{remote_id};

    my (%ret) = request_with_retries(
        logger    => $logger,
        requester => $requester,
        name      => 'load user',
        method    => 'rest_get',
        params    => [
            [ 'customers', @with_id ],
            params  => \%params,
            headers => [
                'Content-Type' => 'application/json',
                'X-api-key'    => $self->flotum->merchant_api_key
            ],
            code => 200
        ]
    );

    my $obj = $ret{obj};
    $obj = $obj->{customers}[0] if exists $obj->{customers};
    die "Resource does not exists\n" unless $obj->{id};
    return $obj;
}

1;
