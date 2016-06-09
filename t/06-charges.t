use common::sense;
use Test::More;
use JSON::MaybeXS;
use Furl;

use DDP;

use_ok('Net::Flotum');
ok( my $flotum = Net::Flotum->new( merchant_api_key => 'm-just-testing' ), 'new ok' );

diag "creating customer";
my $customer = $flotum->new_customer(
    name           => 'cron',
    remote_id      => rand,
    legal_document => rand
);

isa_ok $customer, 'Net::Flotum::Object::Customer';

diag "adding a credit card";

ok(my $cc = $customer->add_credit_card(), 'add credit card');

my $furl = Furl->new(timeout => 10);

my $req = $furl->post(
    $cc->{href},
    [],
    encode_json({
        name_on_card => 'Renato S de Souza',
        number       => '5235058636621892',
        validity     => '201811',
        csc          => '212',
    }),
);

ok($req->is_success, 'request ok');

my $credit_card = decode_json $req->content;

ok ($credit_card->{id}, 'credit card id');

diag "creating charge";

can_ok $customer, 'new_charge';

my $charge = $customer->new_charge(
    amount   => 200,
    currency => 'bra',
    metadata => {
        'Please use' => 'The way you need',
        'but'        => 'Do not use more than 10000 bytes after encoded in JSON',
    }
);

isa_ok $charge, 'Net::Flotum::Object::Charge';

ok($charge->id, 'charge id');

diag "payment";

can_ok $charge, 'payment';

ok(
    my $payment = $charge->payment(
        customer_credit_card_id => $credit_card->{id},
        csc_check               => '212',
    ),
    'payment',
);

is ($payment->{transaction_status}, 'queue', 'transaction_status');

diag "capturing";

can_ok $charge, 'capture';

ok ($charge->capture( description => "is optional" ), 'capture charge');

done_testing();

