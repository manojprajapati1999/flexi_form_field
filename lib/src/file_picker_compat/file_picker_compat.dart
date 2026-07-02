export 'file_picker_compat_stub.dart'
    if (dart.library.io) 'file_picker_compat_io.dart'
    if (dart.library.js_interop) 'file_picker_compat_web.dart';
