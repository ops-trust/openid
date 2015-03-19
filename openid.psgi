use strict;
use warnings;

use openid;

my $app = openid->apply_default_middlewares(openid->psgi_app);
$app;

