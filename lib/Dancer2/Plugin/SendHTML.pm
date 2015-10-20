package Dancer2::Plugin::SendHTML;
use strict;
use warnings;

# ABSTRACT: send html from routes when serializer defined

use Dancer2::Plugin;
use Scalar::Util qw();

register send_html => sub {
    Scalar::Util::weaken( my $dsl  = shift );
    Scalar::Util::weaken( my $route = shift );
    # TODO make content type and charset configurable
    sub {
        # call route and encode content
        my $content = Encode::encode( 'UTF-8', $route->(@_) );
        # stream content
        $dsl->app->send_file(\$content, content_type => 'text/html; charset=UTF-8');
    }
}, { is_global => 1, prototype => '&' };

register_plugin;

1;
