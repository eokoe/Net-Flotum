package Net::Flotum;
use strict;
use 5.008_005;
our $VERSION = '0.01';

use warnings;
use utf8;

use Moo;
use namespace::clean;

has 'flotum_api' => (is => 'rw', default => 'default.flotum.com');

has 'sandbox' => (is => 'rw', default => '0');

has 'merchant_api_key' => (is => 'rw', required => 1);



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

    $customer = $flotum->new_customer(

        name  => 'name here',
        remote_id => 'your id here'

    );

    $customer = $flotum->load_customer(

        # via remote_id
        remote_id => 'foobar',
        # or via id
        id => '0b912879-7c7b-42a1-8f49-722f13b67ae6'

    );

    $http_description = $customer->new_credit_card();

    @credit_cards = $customer->list_credit_cards();


=head1 DESCRIPTION

this is WIP work, please check this page later! Flotum is currently only being used on eokoe.com startups.

Flotum is a solution for storing credit card information and creating charges against it.
It allow you to change between operators (Stripe, Paypal, etc) while keeping your customer credit cards in one place.

=head1 AUTHOR

Renato CRON E<lt>rentocron@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2015-2016 Renato CRON

Thanks to http://eokoe.com

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Business::Payment> L<Business::OnlinePayment>

=cut
