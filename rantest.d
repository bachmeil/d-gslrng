// dmd rantest.d distributions.c gslrng.c mt.c rancommon.c specfun.c -P-I.
import distributions, gslrng, mt;
import std.conv, std.stdio;

void main() {
	auto r = gsl_rng_alloc(gsl_rng_mt19937);
	writeln(gsl_ran_gamma_mt(r, 1.5, 2.5));
	writeln(gsl_ran_gaussian(r, 1.0));
	writeln(gsl_ran_flat(r, 0, 1));
	writeln(gsl_ran_bernoulli(r, 0.5));
	writeln(gsl_ran_beta(r, 0.5, 0.5));
	double x, y;
	gsl_ran_bivariate_gaussian(r, 1.0, 1.0, 0.9, &x, &y);
	writeln("x: ", x, " y: ", y);
	writeln(gsl_ran_binomial_knuth(r, 0.8, 12));
	writeln(gsl_ran_cauchy(r, 0.6));
	writeln(gsl_ran_chisq(r, 6));
	double[] alpha = [2.5, 5.0];
	double[] theta = [0.0, 0.0];
	gsl_ran_dirichlet(r, 2, alpha.ptr, theta.ptr);
	writeln("theta: ", theta);
	double[3] P = [0.59, 0.4, 0.01];
	gsl_ran_discrete_t * g1 = gsl_ran_discrete_preproc(3, P.ptr);
	writeln(gsl_ran_discrete(r, g1));
	writeln(gsl_ran_erlang(r, 3.0, 4.0));
	writeln(gsl_ran_exponential(r, 2.0));
	writeln(gsl_ran_exppow(r, 3.7, 0.3));
	writeln(gsl_ran_laplace(r, 2.75));
	writeln(gsl_ran_fdist(r, 3.0, 4.0));
	writeln(gsl_ran_gaussian_tail(r, 1.7, 0.25));
	writeln(gsl_ran_geometric(r, 0.5));
	writeln(gsl_ran_gumbel1(r, 3.12, 4.56));
	writeln(gsl_ran_hypergeometric(r, 5, 7, 4));
	writeln(gsl_ran_landau(r));
	writeln(gsl_ran_levy(r, 5.0, 1.0));
	writeln(gsl_ran_logarithmic(r, 0.4));
	writeln(gsl_ran_logistic(r, 3.1));
	writeln(gsl_ran_lognormal(r, 2.7, 1.3));
	double[] p = [2.0, 7.0, 1.0];
	uint[3] n;
	gsl_ran_multinomial(r, 3, 100, p.ptr, n.ptr);
	writeln("n: ", n);
	writeln(gsl_ran_binomial(r, 0, 8));
	/* Multivariate Gaussian requires a bunch of matrix and vector stuff */
	writeln(gsl_ran_negative_binomial(r, 0.3, 20.0));
	writeln(gsl_ran_poisson(r, 5.0));
	writeln(gsl_ran_pareto(r, 1.9, 2.75));
	writeln(gsl_ran_pascal(r, 0.8, 3));
	writeln(gsl_ran_rayleigh(r, 1.9));
	x=0;
	y=0;
	gsl_ran_dir_2d(r, &x, &y);
	writeln(atan2(x, y));
	writeln(gsl_ran_tdist(r, 1.75));
	writeln(gsl_ran_weibull(r, 2.97, 1.0));
	
	double[] arr1 = [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9, 11.0];
	auto arr2 = new double[6];
	auto arr3 = new double[9];
	gsl_ran_shuffle(r, arr1.ptr, arr1.length.to!int, double.sizeof);
	writeln(arr1);
	gsl_ran_choose(r, arr2.ptr, arr2.length.to!int, arr1.ptr, arr1.length.to!int, double.sizeof);
	writeln(arr2);
	gsl_ran_sample(r, arr3.ptr, arr3.length.to!int, arr1.ptr, arr1.length.to!int, double.sizeof);
  writeln(arr3);
}










