use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

my $cus = $flotum->new_customer(
    name           => 'cron',
    remote_id      => rand,
    legal_document => rand
);
is($cus->loaded, '0', 'object is not loaded');
is($cus->name, 'cron', 'name lazy loaded ok');
is($cus->loaded, '1', 'object is loaded');

done_testing;
