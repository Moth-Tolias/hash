module hash.hash;

uint hash(Arg...)(in Arg a) pure @safe @nogc
{
	uint result;

	foreach(t; a)
	{
		uint hash;
		typeof(t)[1] hashable = t;

		import std.digest.crc : crc32Of;
		auto crc = crc32Of(hashable); // caution: does not work on classes!
		foreach(i, ubyte u; crc)
		{
			hash |= u << (i * (ubyte.sizeof * 8));
		}

		result ^= hash; //xor is fine for our purposes
	}

	return result;
}

unittest
{
	auto res1 = hash(1);
	auto res2 = hash(2);
	auto res3 = hash(1, 2);

	struct S
	{
		int x;
		int y;
	}

	S s;
	auto res4 = hash(1, 2, s);

	S s2;

	assert(hash(s) == hash(s2));

	assert(res1 != res2); //is there a way to dry this?
	assert(res1 != res3);
	assert(res1 != res4);

	assert(res2 != res3);
	assert(res2 != res4);

	assert(res3 != res4);
}
