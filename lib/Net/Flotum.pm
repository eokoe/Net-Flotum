package Net::Flotum;
use strict;
use 5.008_005;
our $VERSION = '0.01';

use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;

use Net::Flotum::Object::Customer;

has 'flotum_api' => ( is => 'rw', default => 'default.flotum.com' );
has 'merchant_id'  => ( is => 'rw', required => 1 );
has 'merchant_api_key' => ( is => 'rw', required => 1 );

sub load_customer {
    my ( $self, %opts ) = @_;

    croak 'missing parameter: `remote_id` or `id` is required'
      if ( !exists $opts{remote_id} || !defined $opts{remote_id} )
      || ( !exists $opts{remote_id} || !defined $opts{remote_id} );

}

sub new_customer {
    my ( $self, %opts ) = @_;

    return Net::Flotum::Object::Customer->new(
        flotum      => $self,
        %opts
    );
}

1;

__END__

=encoding utf-8

=head1 NAME

Net-Flotum - use Flotum as your payment gateway

=head1 SYNOPSIS

    use Net::Flotum;

    $flotum = Net::Flotum->new(
        merchant_api_key => 'foobar',
        flotum_api       => 'default.flotum.com'
    );

    # returns a Net::Flotum::Object::Customer
    $customer = $flotum->new_customer(

        name  => 'name here',
        remote_id => 'your id here'

    );

    # returns a Net::Flotum::Object::Customer
    $customer = $flotum->load_customer(

        # via remote_id
        remote_id => 'foobar',
        # or via id
        id => '0b912879-7c7b-42a1-8f49-722f13b67ae6'

    );

    # returns a hash reference containing details for creating an credit card.
    $http_description = $customer->new_credit_card();

    # returns a list of Net::Flotum::Object::CreditCard
    @credit_cards = $customer->list_credit_cards();


=head1 DESCRIPTION

this is WIP work, please check this page later! Flotum is currently only being used on eokoe.com startups.

Flotum is a solution for storing credit card information and creating charges against it.
It allow you to change between operators (Stripe, Paypal, etc) while keeping your customer credit cards in one place.

=head1 AUTHOR

Renato CRON E<lt>rentocron@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2015-2016 Renato CRON

Owing to http://eokoe.com

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Business::Payment> L<Business::OnlinePayment>

=cut
