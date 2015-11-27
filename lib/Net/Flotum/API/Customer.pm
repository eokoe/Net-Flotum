package Net::Flotum::API::Customer;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;
use JSON::MaybeXS;
use Net::Flotum::API::ExceptionHandler;

has 'flotum' => ( is => 'ro', weak_ref => 1, );

sub exec_new_customer {
    my ( $self, %opts ) = @_;

    my $requester = $self->flotum->requester;
    my $logger    = $self->flotum->logger;

    request_with_retries(
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
            code  => 201,
            stash => 'new-customer',

            data => encode_json( \%opts )
        ]
    );

    return {}

}

1;
