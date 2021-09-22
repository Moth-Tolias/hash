module hash.splitmix;

/// implementation of splitMix64 random number generator
ulong splitMix64(in ulong seed, in long offset) @safe pure @nogc nothrow
{
	// using constants as described by Andrew Clifton
	// in his 2020 virtual Roguelike Celebration talk
	// https://twicetwo.com/files/generate-hash-notes.md

	enum gamma = 0x9e3779b97f4a7c15;
	ulong result = seed + (offset * gamma);

	enum mu1 = 0xbf58476d1ce4e5b9;
	enum mu2 = 0x94d049bb133111eb;

	enum r1 = 30;
	enum r2 = 27;
	enum r3 = 31;

	result = (result ^ (result >> r1)) * mu1;
	result = (result ^ (result >> r2)) * mu2;
	result = (result ^ (result >> r3));

	return result;
}
