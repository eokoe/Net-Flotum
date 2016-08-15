package Net::Flotum::Logger::Log4perl;
use strict;
use Moo;

use Log::Log4perl qw(:easy);

Log::Log4perl->easy_init(
    {
        level  => $DEBUG,
        layout => '%p{1}%d{yyyy-MM-dd HH:mm:ss.SSS}[%P] %m{indent=1}%n',
        'utf8' => 1
    }
);

has 'logger' => ( is => 'rw', lazy => 1, builder => '_build_logger' );

sub _build_logger {
    get_logger;
}
1;
