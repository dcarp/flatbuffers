module flatbuffers;

import std.typecons : Flag, No, Yes;

alias uoffset_t = uint;
alias soffset_t = int;
alias voffset_t = ushort;

auto flatDefaultValue(T)()
{
    import std.traits : hasMember, isFloatingPoint;

    static if (isFloatingPoint!T)
        return cast(T) 0.0;
    else static if ((is(T == class) || is(T == struct)) && hasMember!(T, "flatDefaultValue"))
        return T.flatDefaultValue;
    else
        return T.init;
}

enum flatKey = Yes.flatKey;

enum FlatHash
{
    none,
    fnv1_32,
    fnv1_64,
    fnv1a_32,
    fnv1a_64,
}

mixin template FlatField(ushort id, alias Type, string name, A...)
{
    Type defaultValue = flatDefaultValue!Type, Flag!"key" isKey = No.key,
    FlatHash hash = FlatHash.none)
    int foo;
}


/*

id <- ushort


required <- bool
nested_flatbuffer <- string; table name
flexbuffer <- bool
key <- bool
hash <- enum

original_order <- bool for table


deprecated <- bool
force_align <- ubyte
bit_flags <- bool
*/
