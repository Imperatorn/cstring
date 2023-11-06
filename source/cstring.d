module cstring;
import std.string;

struct Cstring
{
	private string data;
	private size_t index;

	alias toCharPtr this;

	char* toCharPtr() const
	{
		return cast(char*) data.toStringz;
	}

	this(char* p)
	{
		data = fromStringz(p).idup;
	}

	this(string p)
	{
		data = p;
	}

	size_t toHash() const
	{
		return data.hashOf;
	}

	bool opEquals(Cstring other) const
	{
		return data == other.data;
	}

	bool opEquals(string other) const
	{
		return data == other;
	}

	void opAssign(string s)
	{
		data = s;
		index = 0;
	}

	void opAssign(char* s)
	{
		data = fromStringz(s).idup;
		index = 0;
	}

	bool empty() const
	{
		return index >= data.length;
	}

	char front() const
	{
		return data[index];
	}

	void popFront()
	{
		if (index < data.length)
			index++;
	}
}

unittest
{
	import std.stdio;	
	import core.stdc.stdlib;
	import core.internal.hash;

	string t1 = "Hello";
	char* t2 = cast(char*) "Hello".toStringz;

	Cstring s3 = "Hello";

	Cstring s1 = t1;
	Cstring s2 = t2;

	assert(s1 == s2, "Strings are not equal");
	assert(s2 == s3, "Strings are not equal");

	string r;

	foreach (s; s3)
		r ~= s;

	assert(r == s3, "String are not equal");
}
