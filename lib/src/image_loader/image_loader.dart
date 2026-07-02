import 'package:flutter/material.dart';

/// Stub function for loading local file-based images.
/// 
/// Throws [UnsupportedError] if called on platforms that do not support dart:io.
Widget getFileImageWidget(String path, {BoxFit? fit}) {
  throw UnsupportedError('Cannot create file image on this platform.');
}
