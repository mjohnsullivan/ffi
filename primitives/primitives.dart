import 'dart:ffi' as ffi;

/*
@ffi.struct
class Data extends ffi.Pointer<ffi.Void> {
  @ffi.Int32()
  int someInt;

  external static int sizeOf();

  @override
  Data offsetBy(int offsetInBytes) => super.offsetBy(offsetInBytes).cast();

  @override
  Data elementAt(int index) => offsetBy(sizeOf() * index);

  static Data allocate({int count: 1}) =>
      ffi.allocate<ffi.Uint8>(count: count * sizeOf()).cast();

  factory Data(int val) => Data.allocate()..someInt = val;
}

typedef some_data_func = Data Function(ffi.Int32 some_int);
typedef SomeData = Data Function(int someInt);
*/

typedef sum_func = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);

main() {
  final dylib = ffi.DynamicLibrary.open('primitives.dylib');
  final sumPointer = dylib.lookup<ffi.NativeFunction<sum_func>>('sum');
  final sum = sumPointer.asFunction<Sum>();
  print('${sum(5, 6)}');
}
