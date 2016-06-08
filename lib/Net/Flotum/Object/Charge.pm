package Net::Flotum::Object::Charge;
use common::sense;
use Moo;
use Carp;

has flotum => (
    is       => "ro",
    weak_ref => 1,
);

has id => (
    is => "rw",
);

has charge => (
    is       => "rw",
    weak_ref => 1,
);

1;

__END__

=encoding utf-8

=head1 NAME

Net::Flotum::Object::Charge - Flotum charge object representation

=head1 SYNOPSIS

Please read L<Net::Flotum>

=head1 AUTHOR

Junior Moraes L<juniorfvox@gmail.com|mailto:juniorfvox@gmail.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
