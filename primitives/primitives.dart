import 'dart:ffi' as ffi;

// C sum function - int sum(int a, int b);
typedef sum_func = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);

// C subtract function - int subtract(int *a, int b);
typedef subtract_func = ffi.Int32 Function(
    ffi.Pointer<ffi.Int32> a, ffi.Int32 b);
typedef Subtract = int Function(ffi.Pointer<ffi.Int32> a, int b);

// C multiply function - int *multiply(int a, int b);
typedef multiply_func = ffi.Pointer<ffi.Int32> Function(
    ffi.Int32 a, ffi.Int32 b);
typedef Multiply = ffi.Pointer<ffi.Int32> Function(int a, int b);

main() {
  final dylib = ffi.DynamicLibrary.open('primitives.dylib');

  // calls int sum(int a, int b);
  final sumPointer = dylib.lookup<ffi.NativeFunction<sum_func>>('sum');
  final sum = sumPointer.asFunction<Sum>();
  print('3 + 5 = ${sum(3, 5)}');

  // calls int subtract(int *a, int b);
  final p = ffi.Pointer<ffi.Int32>.allocate();
  p.store(3);
  final subtractPointer =
      dylib.lookup<ffi.NativeFunction<subtract_func>>('subtract');
  final subtract = subtractPointer.asFunction<Subtract>();
  print('3 - 5 = ${subtract(p, 5)}');

  // calls int *multiply(int a, int b);
  final multiplyPointer =
      dylib.lookup<ffi.NativeFunction<multiply_func>>('multiply');
  final multiply = multiplyPointer.asFunction<Multiply>();
  final result = multiply(3, 5);
  print('3 * 5 = ${result.load<int>()}');
}
