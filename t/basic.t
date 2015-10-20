use strict;
use warnings;

use Test::More import => ['!pass'];
use Plack::Test;
use HTTP::Request::Common;

{
    package Test::App::SendHTML;
    use Dancer2;
    use Dancer2::Plugin::SendHTML;

    set serializer => 'YAML';
    set template => 'TemplateToolkit';

    get '/' => send_html sub {
        return "Hello, world";
    };

}

my $test = Plack::Test->create( Test::App::SendHTML->to_app );
my $res = $test->request( GET '/' );
is $res->code, '200';

diag $res->content;

done_testing();