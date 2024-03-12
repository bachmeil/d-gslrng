# d-gslrng

This is a version of the GNU Scientific Library random number distributions that can be compiled by DMD for direct use in a D program. One advantage is that you don't have to mess around with shared libraries - add the files to your project and you're good to go. Another is that you don't have the bulk of the full GSL. Anything not needed for generating random numbers is stripped out.

## Notes

- This project is still at an early stage (March 2024). I've not turned it into a Dub project. You need to use the 2.108.0 version of DMD, which as of this writing is still a beta compiler. That's the release that incorporated broad C macro support, without which this would not work.
- There were no changes to any of the code. It's all copied and pasted from the GSL sources. The quality and reliability of this code is the same as the original. You should not hesitate to use it in production.
- There's no documentation. There probably won't be either, since you can already read the GSL's excellent documentation, and it's the same code.
- I've included one of L'Ecuyer's parallel random number generators that I ported from Java. There is an example of its use in this repo. It was extensively tested against the Java version and produced the exact same streams of numbers even after generating billions of draws with hundreds of streams. That was on 64-bit Intel. No testing was done on 32-bit or ARM.
- The two multivariate distributions, multivariate Gaussian and Wishart, are not yet included. That's because they drag in a lot of matrix and vector dependencies. I'll have to decide how to handle those dependencies first.
- The licenses remain the same as the originals. The GSL is GPL 3, so that's retained. The parallel RNG is Apache, so that's retained. If this does not work for you, you'll need to look for alternative options, because I don't have the option to change the license to Boost or MIT on code written by someone else.
- The only included GSL generator is Mersenne Twister. To my knowledge, that's the one everyone wants to use, but I could be wrong. I don't want to load up this library with code nobody will ever use. Create an issue if you have a use for other generators.
- Create a discussion if you have any questions. Create an issue if you think you've found a bug. 

## Examples

There are two examples in this repo. rantest.d demonstrates sequential RNG using the Mersenne Twister. testgslprng.d is an example using std.parallel for an embarrassingly parallel problem. Presumably the MT will be much faster if you have only one stream (not all scenarios are embarrassingly parallel) but I have not tested that conjecture.

Sequential example:

```
dmd rantest.d distributions.c gslrng.c mt.c rancommon.c specfun.c -P-I.
```

Parallel example:

```
dmd testgslprng.d distributions.c gslrng.c prng.d rancommon.c specfun.c -P-I.
```

I will repeat what I wrote above. At the time I'm writing this (March 2024) you need to use DMD 2.108.0, which is currently a beta release. It will fail to compile if you don't have the extensive support for C macros that was added in that release. You can find the beta [on this page](https://downloads.dlang.org/pre-releases/2024/). Of course, if there's been a newer release, you should use that instead of a beta.
