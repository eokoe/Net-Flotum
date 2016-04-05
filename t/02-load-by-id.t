use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

my $cus2 = $flotum->new_customer(
    name           => 'cron',
    remote_id      => rand,
    legal_document => rand
);

is( $cus2->loaded, '0', 'object is not loaded' );

my $cus = $flotum->load_customer( id => $cus2->id );

is( $cus->loaded, '1',    'object is already loaded' );
is( $cus->name,   'cron', 'name is cron' );

is( $cus2->id, $cus->id, 'id is the same' );

done_testing;
