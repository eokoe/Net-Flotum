use strict;
use Test::More;
use Furl;
use JSON::MaybeXS;

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
like( $info->{href}, qr|localhostx|,    'request href has callback' );

ok( $info->{valid_until}, 'request has a time to expire.' );

my $furl = Furl->new( timeout => 15, );

my $res = $furl->post(
    $info->{href},
    [ 'content-type' => 'application/json' ],    # headers
    encode_json {
        name_on_card => 'This is a fake credit card',
        csc          => '123',
        number       => '5268590528188853',
        validity     => '201801',
        brand        => 'mastercard'
    }
);

ok( $res->is_success, 'credit card created' );

my @cards = $cus->list_credit_cards;
is( @cards, 1, 'one card' );
my $card = $cards[0];

is( $card->mask,             '5268*********853', 'mask ok' );
is( $card->conjecture_brand, 'mastercard',       'brand is ok' );
is( $card->validity,         '201801',           'validity is ok' );

is( $cards[0]->remove, '1', 'removed' );

done_testing;
