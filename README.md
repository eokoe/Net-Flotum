# NAME

Net-Flotum - use Flotum as your payment gateway

# SYNOPSIS

    use Net::Flotum;

    $flotum = Net::Flotum->new(
        merchant_api_key => 'foobar',
    );

    # returns a Net::Flotum::Object::Customer
    $customer = $flotum->new_customer(

        name  => 'name here',
        remote_id => 'your id here',
        legal_document => '...',
        default_address_neighbourhood => '...'
    );

    # returns a Net::Flotum::Object::Customer
    $customer = $flotum->load_customer(

        # via remote_id
        remote_id => 'foobar',
        # or via id
        id => '0b912879-7c7b-42a1-8f49-722f13b67ae6'

    );

    # returns a hash reference containing details for creating an credit card.
    $http_description = $customer->new_credit_card();
    # something like that
    {
        accept     :  "application/json",
        fields     :  {
            address_city         :  "?Str",
            address_inputed_at   :  "?GmtDateTime",
            address_name         :  "?Str",
            address_neighbourhood:  "?Str",
            address_number       :  "?Str",
            address_observation  :  "?Str",
            address_state        :  "?Str",
            address_street       :  "?Str",
            address_zip          :  "?Str",
            brand                :  "*Brand",
            csc                  :  "*CSC",
            legal_document       :  "*Str",
            name_on_card         :  "*Str",
            number               :  "*CreditCard",
            validity             :  "*YYYYDD"
        },
        href       :  "https://default.flotum.com/customers/9baa2e37-2cb0-4c5c-9fe0-b2d91fdd53fe/credit-cards/?api_key=xxxx",
        method     :  "POST",
        valid_until:  1448902516
    }
    # ? means not required
    # * means required.
    # Str = Any String, CreditCard = credit card number, YYYYMD = Year+Month (2 pad)
    # Brands acceptance may vary, but may be one or more of bellow:
    # visa|mastercard|discover|americanexpress|jcb|enroute|bankcard|solo|chinaunionpay|laser|isracard|aura|elo


    # returns a list of Net::Flotum::Object::CreditCard
    @credit_cards = $customer->list_credit_cards();

# DESCRIPTION

this is WIP work, please check this page later! Flotum is currently only being used on eokoe.com startups.

Flotum is a solution for storing credit card information and creating charges against it.
It allow you to change between operators (Stripe, Paypal, etc) while keeping your customer credit cards in one place.

# AUTHOR

Renato CRON <rentocron@cpan.org>

# COPYRIGHT

Copyright 2015-2016 Renato CRON

Owing to http://eokoe.com

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Business::Payment](https://metacpan.org/pod/Business::Payment) [Business::OnlinePayment](https://metacpan.org/pod/Business::OnlinePayment)
