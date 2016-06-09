use common::sense;
use Test::More;
use JSON::MaybeXS;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

diag "creating customer";
my $customer = $flotum->new_customer(
    name           => 'cron',
    remote_id      => rand,
    legal_document => rand
);

isa_ok $customer, 'Net::Flotum::Object::Customer';

diag "creating charge";

can_ok $customer, 'new_charge';

my $charge = $customer->new_charge(
    amount                      => 200,
    currency                    => 'bra',
    metadata                    => {
        'Please use' => 'The way you need',
        'but'        => 'Do not use more than 10000 bytes after encoded in JSON',
    }
);

isa_ok $charge, 'Net::Flotum::Object::Charge';

ok($charge->id, 'charge id');

diag "capturing";

can_ok $charge, 'capture';

ok ($charge->capture( description => "is optional" ), 'capture charge');

done_testing();

