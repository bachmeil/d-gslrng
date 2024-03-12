// dmd testgslprng.d distributions.c gslrng.c prng.d rancommon.c specfun.c -P-I.
import distributions, gslrng, prng;
import std.parallelism, std.stdio;

void main() {
	StreamGen sg;
	
	// Create an array of GSLStream structs
	Stream[] streams;
	foreach(_; 0..totalCPUs) {
		streams ~= sg.createStream();
	}
	
	// This function has to be static for it to used with a template
	static double[] simulate(Stream s) {
		auto r = GslRng(s);
		double[] result;
		foreach(_; 0..20) {
			result ~= gsl_ran_ugaussian(r);
		}
		return result;
	}
	
	// Work over the streams in parallel
	auto result = taskPool.map!simulate(streams);
	writeln(result);
  writeln("Total CPUs: ", totalCPUs);
}
