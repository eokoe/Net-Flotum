package Net::Flotum::Object::Customer;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;

has 'flotum' => ( is => 'ro', weak_ref => 1, );
has 'id' => ( is => 'ro', required => 1 );


for (
    qw/
    name remote_id legal_document
    default_address_name default_address_zip default_address_street default_address_number
    default_address_observation default_address_neighbourhood default_address_city default_address_state
    default_address_inputed_at
    /
  ) {
    has $_ => ( is => 'ro' );
    before $_ => sub {
        use DDP; p "foo";
    }
}



sub new_credit_card {

}

sub list_credit_cards {


}

1;

__END__

=encoding utf-8

=head1 NAME

Net::Flotum::Object::Customer - Flotum customer object represetation

=head1 SYNOPSIS

Please read L<Net::Flotum>

=head1 AUTHOR

Renato CRON E<lt>rentocron@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2015-2016 Renato CRON

Owing to http://eokoe.com

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
