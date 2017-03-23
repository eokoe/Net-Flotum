package Net::Flotum::Logger::Log4perl;
use strict;
use Moo;

use Log::Any;

has 'logger' => ( is => 'rw', lazy => 1, builder => '_build_logger' );

sub _build_logger {
    Log::Any->get_logger;
}
1;
