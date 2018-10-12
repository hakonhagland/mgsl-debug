package Math::GSL::Const::Test;
use base q{Test::Class};
use Test::More tests => 6;
use Math::GSL        qw/:all/;
use Math::GSL::SF    qw/:all/;
use Math::GSL::Const qw/:all/;
use Math::GSL::Test  qw/:all/;
use Math::GSL::Errno qw/:all/;
use strict;
BEGIN { gsl_set_error_handler_off() }

sub make_fixture : Test(setup) {
    my $self = shift;
}

sub teardown : Test(teardown) {
}

sub GSL_CONST_CGS : Tests {
    my $self = shift;
    cmp_ok( $GSL_CONST_CGS_SPEED_OF_LIGHT ,'==',   29979245800  );
}

sub MATH_CONSTANTS : Tests {
    my $self = shift;
    ok_similar( gsl_sf_log($M_E), 1,'ln($M_E)=1');
    ok_similar( gsl_sf_exp($M_LN2), 2,'e^($M_LN2)=2' );
    ok_similar( gsl_sf_exp($M_LNPI), $M_PI ,'e^($M_LNPI)=$M_PI');
    ok_similar( $M_SQRT2 ** 2, 2,'($M_SQRT2)**2=2' );
    ok_similar( $M_EULER, 0.577215664901532860606512090082 );
}

Test::Class->runtests;
