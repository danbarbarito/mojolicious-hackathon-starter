package MojoliciousHackathonStarter;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;
use Crypt::PBKDF2;
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin(Webpack => {process => [qw(js css vue sass)]});

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});


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

  $r->get('/login')->to('auth#login');
  $r->post('/login')->to('auth#login');

  $r->get('/signup')->to('auth#signup');
  $r->post('/signup')->to('auth#signup');

  $r->get('/logout')->to('auth#logout');
}

1;
