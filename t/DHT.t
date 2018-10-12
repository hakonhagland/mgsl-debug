package Math::GSL::DHT::Test;
use base q{Test::Class};
use Test::Most;
use Math::GSL        qw/:all/;
use Math::GSL::DHT   qw/:all/;
use Math::GSL::Errno qw/:all/;
use Math::GSL::Test  qw/:all/;
use Data::Dumper;
use strict;
use warnings;

BEGIN { gsl_set_error_handler_off(); }

sub make_fixture : Test(setup) {
}

sub teardown : Test(teardown) {
}

sub GSL_DHT_ALLOC_FREE : Tests {
    my $dht = gsl_dht_alloc(5);
    isa_ok($dht, 'Math::GSL::DHT');

    my $status = gsl_dht_init($dht, 1.0, 50);
    ok_status($status);

    gsl_dht_free($dht);
    ok(!$@, 'gsl_dht_free');
}

sub DHT_NEW : Tests {
    my $dht = gsl_dht_new(128, 1.0, 20);
    isa_ok($dht, 'Math::GSL::DHT' );
}

sub DHT_SAMPLE_APPLY : Tests {
    my $f_in  = [(0) x 128 ];
    my $f_out = [(0) x 128 ];
    my $dht = gsl_dht_new(128, 1.0, 20);

    for my $n (0..127) {
            my $x = gsl_dht_x_sample($dht, $n);
            $f_in->[$n] = exp(-$x);
    }
    my $k = gsl_dht_k_sample($dht, 127);
    ok($k, "k=$k");
    ok( $#$f_in = 127, 'gsl_dht_x_sample' );

    ok_status( gsl_dht_apply($dht, $f_in, $f_out));
    ok( $#$f_out = 127, 'gsl_dht_apply' );

    local $TODO = 'need a typemap for $f_in and $f_out';
    # check that the relative error at most 2%
    ok(
        is_similar_relative ($f_out->[0], 0.181, 0.02),
        "gsl_dht_apply output @{[$f_out->[0]]} != 0.181"
    );
}

Test::Class->runtests;
