module hash.hash;

/// hash an arbitrary amount of values
ulong hash(in ulong[] values...) pure @safe @nogc nothrow
{
	ulong result;

	foreach(ulong value; values)
	{
		import hash.splitmix;
		immutable temp = splitMix64(value, 0);
		result ^= temp; //xor is fine for our purposes
	}

	return result;
}

@safe @nogc nothrow unittest
{
	immutable res1 = hash(1);
	immutable res2 = hash(2, -2);
	immutable res3 = hash(1, 2);

	assert(res1 != res2); //is there a way to dry this?
	assert(res1 != res3);

	assert(res2 != res3);
}

unittest
{
	import std.stdio : writeln;
	writeln("+1: ", hash(1));
	writeln("-1: ", hash(-1));
	writeln("1, 2: ", hash(1, 2, 3));
}
