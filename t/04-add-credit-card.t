use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

my $cus = $flotum->new_customer(
    name           => 'cron',
    legal_document => rand
);

my $info = $cus->add_credit_card( callback => 'http://localhostx:2202/too' );
is( $info->{fields}{number}, '*CreditCard', 'Credit card number is required' );

ok( $info->{href}, 'request has an href' );
like( $info->{href}, qr|/credit-cards|, 'request href like *credit-cards*' );
like( $info->{href}, qr|localhostx|, 'request href has callback' );

ok( $info->{valid_until}, 'request has a time to expire.' );

done_testing;
