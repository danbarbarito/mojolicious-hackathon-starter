package MojoliciousHackathonStarter::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

use Mojo::JSON qw(decode_json);

# This action will render a template
sub welcome {
    my $self = shift;

    # Render template "example/welcome.html.ep" with message
    $self->render( msg =>
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
    );
}

# Global / useful variables that javascript will use
sub global_vars {
    my $self = shift;

    $self->render( json => {
      'current-user' => $self->session('current-user')
    });
}

1;
