requires 'perl', '5.008005';

requires 'Moo';
requires 'URI';
requires 'HTTP::Request::Common';
requires 'Carp';
requires 'namespace::clean';
requires 'JSON', '2.34';
requires 'JSON::MaybeXS';
requires 'Stash::REST';
requires 'Furl';
requires 'Log::Log4perl';

on test => sub {
    requires 'Test::More', '0.96';

    requires 'HTTP::Response';
    requires 'LWP::UserAgent';
    requires 'URL::Encode', '0.03';
    requires 'Test::Pod';
};
