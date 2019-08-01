import 'dart:convert';
import 'dart:ffi' as ffi;
/*
class Place extends ffi.Struct {
  @ffi.Double()
  double latitude;
  @ffi.Double()
  double longitude;

  external static int sizeOf();

  @override
  Place offsetBy(int offsetInBytes) => super.offsetBy(offsetInBytes).cast();

  @override
  Place elementAt(int index) => offsetBy(sizeOf() * index);

  static Place allocate({int count: 1}) =>
      ffi.allocate<ffi.Uint8>(count: count * sizeOf()).cast();

  factory Place(int val) => Place.allocate()..someInt = val;
}

typedef some_Place_func = Place Function(ffi.Int32 some_int);
typedef SomePlace = Place Function(int someInt);
*/

// Example of using structs to pass strings to and from Dart/C
class Utf8 extends ffi.Struct<Utf8> {
  @ffi.Uint8()
  int char;

  static String fromUtf8(ffi.Pointer<Utf8> str) {
    List<int> units = [];
    int len = 0;
    while (true) {
      int char = str.elementAt(len++).load<Utf8>().char;
      if (char == 0) break;
      units.add(char);
    }
    return Utf8Decoder().convert(units);
  }

  static ffi.Pointer<Utf8> toUtf8(String s) {
    List<int> units = Utf8Encoder().convert(s);
    ffi.Pointer<Utf8> result =
        ffi.Pointer<Utf8>.allocate(count: units.length + 1).cast();
    for (int i = 0; i < units.length; i++) {
      result.elementAt(i).load<Utf8>().char = units[i];
    }
    result.elementAt(units.length).load<Utf8>().char = 0;
    return result;
  }
}

// C string pointer return function - char *hello_world();
typedef hello_world_func = ffi.Pointer<Utf8> Function();
typedef HelloWorld = ffi.Pointer<Utf8> Function();

// C string parameter pointer function - char *reverse(char *str, int length);
// C string pointer return function - char *hello_world();
typedef reverse_func = ffi.Pointer<Utf8> Function(
    ffi.Pointer<Utf8> str, ffi.Int32 length);
typedef Reverse = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8> str, int length);

main() {
  final dylib = ffi.DynamicLibrary.open('structs.dylib');

  final helloWorldPointer =
      dylib.lookup<ffi.NativeFunction<hello_world_func>>('hello_world');
  final helloWorld = helloWorldPointer.asFunction<HelloWorld>();
  final message = Utf8.fromUtf8(helloWorld());
  print('$message');

  final reversePointer =
      dylib.lookup<ffi.NativeFunction<reverse_func>>('reverse');
  final reverse = reversePointer.asFunction<Reverse>();
  final reversedMessage = Utf8.fromUtf8(reverse(Utf8.toUtf8('backwards'), 9));
  print('$reversedMessage');
}
