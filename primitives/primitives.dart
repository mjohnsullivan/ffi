import 'dart:ffi' as ffi;

// C sum function - int sum(int a, int b);
// Example of how to pass paramters into C and use the returned result
typedef sum_func = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);

// C subtract function - int subtract(int *a, int b);
// Example of how to create pointers in Dart, alloc them, and pass them as parameters
typedef subtract_func = ffi.Int32 Function(
    ffi.Pointer<ffi.Int32> a, ffi.Int32 b);
typedef Subtract = int Function(ffi.Pointer<ffi.Int32> a, int b);

// C multiply function - int *multiply(int a, int b);
// Example of how to receive pointers in Dart and access the data
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
  // Create a pointer
  final p = ffi.Pointer<ffi.Int32>.allocate();
  // Place a value into the address
  p.store(3);
  final subtractPointer =
      dylib.lookup<ffi.NativeFunction<subtract_func>>('subtract');
  final subtract = subtractPointer.asFunction<Subtract>();
  print('3 - 5 = ${subtract(p, 5)}');

  // calls int *multiply(int a, int b);
  final multiplyPointer =
      dylib.lookup<ffi.NativeFunction<multiply_func>>('multiply');
  final multiply = multiplyPointer.asFunction<Multiply>();
  final resultPointer = multiply(3, 5);
  // Fetch the result at the address pointed to
  final result = resultPointer.load<int>();
  print('3 * 5 = $result');
}
