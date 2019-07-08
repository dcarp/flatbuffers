struct FlatDefaultValue(T)
{
    T defaultValue;
}

T flatDefaultValue(T)(T defaultValue)
{
    return defaultValue;
}

mixin template Bla(T, string name,  A...)
{
    T b= 7.3;
    T j=8.4;
    mixin("int " ~ name ~ "= 30;");
    string gugu = A.stringof;
}

struct Foo
{
    @(Bar.i) int i;
    @(Bar.j, 3) mixin Bla!(float, "abc", int, 3, flatDefaultValue(0.0));
}

enum Bar
{
    i, j,
}

int main()
{
    import std.traits :getUDAs;
    import std.stdio: writeln;
    Foo foo;

    writeln([foo.i, foo.b, foo.j, foo.abc]);
    writeln(foo.gugu);

    pragma(msg, getUDAs!(foo.i, Bar));
    pragma(msg, getUDAs!(foo.abc, Bar));
    pragma(msg, getUDAs!(foo.abc, 3));

    return 0;
}
