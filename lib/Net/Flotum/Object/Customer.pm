package Net::Flotum::Object::Customer;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;

has 'flotum' => ( is => 'ro',  weak_ref => 1, );
has 'id'     => ( is => 'rwp', required => 1 );
has 'loaded' => ( is => 'rwp', default  => 0 );

for (
    qw/
    name remote_id legal_document
    default_address_name default_address_zip default_address_street default_address_number
    default_address_observation default_address_neighbourhood default_address_city default_address_state
    default_address_inputed_at
    /
  ) {
    has $_ => ( is => 'rwp' );
    before $_ => sub {
        my ($self) = @_;
        return if $self->loaded;

        $self->_load_from_id;
      }
}

sub _load_from_id {
    my ($self) = @_;
    my $mydata = $self->flotum->_get_customer_data( id => $self->id );
    for my $field ( keys %$mydata ) {
        if ( $self->can($field) ) {
            my $method = "_set_$field";
            $self->$method( $mydata->{$field} );
        }
    }
    $self->_set_loaded(1);
}

sub _load_from_remote_id {
    my ( $self, $remote_id ) = @_;
    my $mydata = $self->flotum->_get_customer_data( remote_id => $remote_id );
    for my $field ( keys %$mydata ) {
        if ( $self->can($field) ) {
            my $method = "_set_$field";
            $self->$method( $mydata->{$field} );
        }
    }
    $self->_set_loaded(1);
}

sub add_credit_card {
    my ($self) = @_;

    my $session = $self->flotum->_get_customer_session_key( id => $self->id );

    return {
        method => 'POST',
        href   => ( join '/', $self->flotum->requester->flotum_api, 'customers', $self->id, '?api_key=' . $session ),
        valid_until => time + 900,
        fields      => {
            (
                map { $_ => '?Str' }
                  qw/address_name
                  address_zip
                  address_street
                  address_number
                  address_observation
                  address_neighbourhood
                  address_city
                  address_state/
            ),
            ( map { $_ => '*Str' } qw/name_on_card legal_document/ ),
            number   => '*CreditCard',
            csc      => '*CSC',
            brand    => '*Brand',
            validity => '*YYYYDD',
            address_inputed_at => '?GmtDateTime',
        },
        accept => 'application/json'
    };
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
