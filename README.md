# Experiments with Dart FFI

A series of simple examples demonstrating how to call C libraries from Dart.

## Instructions

The C make files are (currently) written to work on a Mac. To compile the libraries, go to the c folder in each subproject and run:

```bash
make dylib
```

A .dylib file should be created in the parent folder. Navigate to that and run the dart file.

