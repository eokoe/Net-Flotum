use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

my $rand = rand.rand.rand;
my $cus2 = $flotum->new_customer(
    name           => 'cron' . $rand,
    remote_id      => $rand,
    legal_document => rand
);
diag("Created customer remote-id = $rand");
is( $cus2->loaded, '0', 'object is not loaded' );

my $cus = $flotum->load_customer( remote_id => $rand );

is( $cus->loaded, '1',    'object is already loaded' );
is( $cus->name,   'cron'. $rand, 'name is cron' );

is( $cus2->id, $cus->id, 'id is the same' );

done_testing;
