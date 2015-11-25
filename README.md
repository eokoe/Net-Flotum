# NAME

Net-Flotum - use Flotum as your payment gateway

# SYNOPSIS

    use Net::Flotum;

    $flotum = Net::Flotum->new(
        merchant_api_key => 'foobar',
        flotum_api       => 'default.flotum.com'
    );

    $customer = $flotum->new_customer(

        name  => 'name here',
        remote_id => 'your id here'

    );

    $customer = $flotum->load_customer(

        # via remote_id
        remote_id => 'foobar',
        # or via id
        id => '0b912879-7c7b-42a1-8f49-722f13b67ae6'

    );

    $http_description = $customer->new_credit_card();

    @credit_cards = $customer->list_credit_cards();

# DESCRIPTION

this is WIP work, please check this page later! Flotum is currently only being used on eokoe.com startups.

Flotum is a solution for storing credit card information and creating charges against it.
It allow you to change between operators (Stripe, Paypal, etc) while keeping your customer credit cards in one place.

# AUTHOR

Renato CRON <rentocron@cpan.org>

# COPYRIGHT

Copyright 2015-2016 Renato CRON

Thanks to http://eokoe.com

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Business::Payment](https://metacpan.org/pod/Business::Payment) [Business::OnlinePayment](https://metacpan.org/pod/Business::OnlinePayment)
