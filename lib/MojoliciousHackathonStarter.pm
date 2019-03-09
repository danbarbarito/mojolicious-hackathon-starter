package MojoliciousHackathonStarter;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;
use Crypt::PBKDF2;
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Auto reload plugin
  $self->plugin('AutoReload');

  # Configure the application
  $self->secrets($config->{secrets});

  # Add images to static path
  push @{$self->static->paths}, $self->home->child('assets', 'img')->to_string;

  # DB Helpers
  $self->helper(pg => sub { state $pg = Mojo::Pg->new(shift->config('pg')) });

  # Migrate to latest version if necessary
  my $path = $self->home->child('migrations', 'db.sql');
  $self->pg->auto_migrate(1)->migrations->name('db')->from_file($path);

  # Encryption helper
  my $pbkdf2 = Crypt::PBKDF2->new();
  $self->helper(pbkdf2 => sub { return Crypt::PBKDF2->new(); });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/global-vars')->to('example#global_vars');


  $r->any(["GET", "POST"] => '/login')->to('auth#login');
  $r->any(["GET", "POST"] => '/signup')->to('auth#signup');

  $r->get('/logout')->to('auth#logout');
}

1;
