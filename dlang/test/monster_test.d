
import flatbuffers;


enum Color:byte
{
  Red = 0,
  Green,
  Blue = 3,
}

union Any {
  Monster monster;
  TestSimpleTableWithEnum testSimpleTableWithEnum;
}

struct Test {
  short a;
  byte b;
}


class TestSimpleTableWithEnum
{
  mixin FlatField!(0, Color, "color", Color.Green);
}

struct Vec3
{
  align(2):
  float x;
  float y;
  float z;
  double test1;
  Color test2;
  Test test3;
}

struct Ability
{
  @(flatKey) uint id;
  uint distance;
}

class Stat
{
  mixin FlatField!(0, string, "id");
  mixin FlatField!(1, long, "val");
  mixin FlatField!(2, ushort, "count");
}

class Referrable
{
  @(flatKey, FlatHash.fnv1a_64) mixin FlatField!(0, ulong, "id");
}

/// an example documentation comment: monster object
class Monster
{
  pos:Vec3 (id: 0);
  hp:short = 100 (id: 2);
  mana:short = 150 (id: 1);
  name:string (id: 3, required, key);
  color:Color = Blue (id: 6);
  inventory:[ubyte] (id: 5);
  friendly:bool = false (deprecated, priority: 1, id: 4);
  /// an example documentation comment: this will end up in the generated code
  /// multiline too
  testarrayoftables:[Monster] (id: 11);
  testarrayofstring:[string] (id: 10);
  testarrayofstring2:[string] (id: 28);
  testarrayofbools:[bool] (id: 24);
  testarrayofsortedstruct:[Ability] (id: 29);
  enemy:MyGame.Example.Monster (id:12);  // Test referring by full namespace.
  test:Any (id: 8);
  test4:[Test] (id: 9);
  test5:[Test] (id: 31);
  testnestedflatbuffer:[ubyte] (id:13, nested_flatbuffer: "Monster");
  testempty:Stat (id:14);
  testbool:bool (id:15);
  testhashs32_fnv1:int (id:16, hash:"fnv1_32");
  testhashu32_fnv1:uint (id:17, hash:"fnv1_32");
  testhashs64_fnv1:long (id:18, hash:"fnv1_64");
  testhashu64_fnv1:ulong (id:19, hash:"fnv1_64");
  testhashs32_fnv1a:int (id:20, hash:"fnv1a_32");
  testhashu32_fnv1a:uint (id:21, hash:"fnv1a_32", cpp_type:"Stat");
  testhashs64_fnv1a:long (id:22, hash:"fnv1a_64");
  testhashu64_fnv1a:ulong (id:23, hash:"fnv1a_64");
  testf:float = 3.14159 (id:25);
  testf2:float = 3 (id:26);
  testf3:float (id:27);
  flex:[ubyte] (id:30, flexbuffer);
  vector_of_longs:[long] (id:32);
  vector_of_doubles:[double] (id:33);
  parent_namespace_test:InParentNamespace (id:34);
  vector_of_referrables:[Referrable](id:35);
  single_weak_reference:ulong(id:36, hash:"fnv1a_64", cpp_type:"ReferrableT");
  vector_of_weak_references:[ulong](id:37, hash:"fnv1a_64", cpp_type:"ReferrableT");
  vector_of_strong_referrables:[Referrable](id:38, cpp_ptr_type:"std::unique_ptr");                 //was shared_ptr
  co_owning_reference:ulong(id:39, hash:"fnv1a_64", cpp_type:"ReferrableT", cpp_ptr_type:"naked");  //was shared_ptr as well
  vector_of_co_owning_references:[ulong](id:40, hash:"fnv1a_64", cpp_type:"ReferrableT", cpp_ptr_type:"std::unique_ptr", cpp_ptr_type_get:".get()");  //was shared_ptr
  non_owning_reference:ulong(id:41, hash:"fnv1a_64", cpp_type:"ReferrableT", cpp_ptr_type:"naked", cpp_ptr_type_get:"");                              //was weak_ptr
  vector_of_non_owning_references:[ulong](id:42, hash:"fnv1a_64", cpp_type:"ReferrableT", cpp_ptr_type:"naked", cpp_ptr_type_get:"");                 //was weak_ptr
}

table TypeAliases {
    i8:int8;
    u8:uint8;
    i16:int16;
    u16:uint16;
    i32:int32;
    u32:uint32;
    i64:int64;
    u64:uint64;
    f32:float32;
    f64:float64;
    v8:[int8];
    vf64:[float64];
}

rpc_service MonsterStorage {
  Store(Monster):Stat (streaming: "none");
  Retrieve(Stat):Monster (streaming: "server", idempotent);
}

root_type Monster;

file_identifier "MONS";
file_extension "mon";
