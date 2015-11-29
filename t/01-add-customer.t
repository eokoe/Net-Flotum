use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'abc' ), 'new ok' );

my $cus = $flotum->new_customer(
    name           => 'cron',
    remote_id      => '111',
    legal_document => 11
);
use DDP; p $cus;
p $cus->name;

done_testing;
