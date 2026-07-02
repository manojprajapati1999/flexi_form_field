import 'dart:io' as io;
import 'package:flutter/material.dart';

/// Native implementation for loading local file-based images using dart:io.
Widget getFileImageWidget(String path, {BoxFit? fit}) {
  return Image.file(io.File(path), fit: fit);
}
