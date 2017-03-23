use strict;
use Test::More;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

my $cus = $flotum->new_customer(
    name           => 'cron',
    legal_document => rand
);
is( $cus->loaded, '0',    'object is not loaded' );
is( $cus->name,   'cron', 'name lazy loaded ok' );
is( $cus->loaded, '1',    'object is loaded' );

my $ret = $cus->update(
    bank_code                    => '237',
    bank_locator                 => '1234',
    bank_locator_verification    => 1,
    bank_account                 => '1223',
    bank_account_verification    => '1',
    bank_account_document_number => '00000000000',
    bank_account_legal_name      => 'foo bar zum',
);
is( $ret->{id}, $cus->id, 'updated with success and id matches' );

done_testing;
