package Net::Flotum::Object::CreditCard;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use Moo;
use namespace::clean;

has 'flotum' => ( is => 'ro', weak_ref => 1, );

has [
    qw/
      verified_by_any_merchant
      created_at
      id

      mask
      validity
      conjecture_brand

      /
] => ( is => 'ro' );

1;

__END__

=encoding utf-8

=head1 NAME

Net::Flotum::Object::CreditCard - Flotum customer object represetation

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
