package MojoliciousHackathonStarter::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

use Crypt::PBKDF2;

use Data::Dumper;

sub login {
    my $self = shift;

    # Check if parameters have been submitted
    my $v = $self->validation;
    return $self->render() unless $v->has_data;

    $v->required('email');
    $v->required('password');

    my $error_message = "Error signing in. Please try again.";

    # Check if validation failed
    if ( $v->has_error ) {
        $self->stash( { error => $error_message } );
        return $self->render();
    }

    my $existing_user = $self->pg->db->select( 'users', '*',
        ( { email => $v->param('email') } ) )->hashes;

    # Check if user doesnt exist
    if ($existing_user->size == 0) {
        $self->stash( { error => $error_message } );
        return $self->render();
    }

    # Check if password is invalid
    if (!$self->pbkdf2->validate($existing_user->[0]->{password}, $v->param('password'))) {
       $self->stash( { error => $error_message } );
      return $self->render();
    }

    # Render confirmation
    my $existing_user_email = $existing_user->[0]->{email};
    $self->session({'current-user' => $existing_user->[0]});
    $self->flash( { success => "Successfully signed in as $existing_user_email!" } );
    return $self->redirect_to('/');
}

sub signup {
    my $self = shift;

    # Check if parameters have been submitted
    my $v = $self->validation;
    return $self->render() unless $v->has_data;

    # Validate parameters ("pass_again" depends on "pass")
    $v->required('email');
    $v->required('password');
    $v->required('password_confirm')->equal_to('password')
        if $v->optional('password')->size( 7, 500 )->is_valid;

    if ( $v->has_error ) {
        $self->stash(
            {   error =>
                    "There was an error creating the account. Please try again."
            }
        );
        return $self->render();
    }

    my $existing_user = $self->pg->db->select( 'users', '*',
        ( { email => $v->param('email') } ) )->hashes->size > 0;

    if ($existing_user) {
        $self->stash(
            {   error =>
                    "User already exists. Please choose a different name."
            }
        );
        return $self->render();
    }

    my $encrypted_password = $self->pbkdf2->generate( $v->param('password') );

    my $new_id = $self->pg->db->insert(
        'users',
        { email     => $v->param('email'), password => $encrypted_password },
        { returning => 'id' }
    )->hash->{id};

    my $new_user = $self->pg->db->select( 'users', '*',
        ( { id => $new_id } ) )->hashes;

    # Render confirmation
    $self->session({'current-user' => $new_user->[0]});
    $self->flash( { success => "Your account ($new_id) has been created!" } );
    return $self->redirect_to('/');
}

sub logout {
    my $self = shift;

    $self->session({'current-user' => undef});
    $self->flash( { success => "You have been signed out" } );
    return $self->redirect_to('/');
}

1;
