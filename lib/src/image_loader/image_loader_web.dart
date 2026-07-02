import 'package:flutter/material.dart';

/// Web/Wasm implementation that returns a fallback placeholder.
Widget getFileImageWidget(String path, {BoxFit? fit}) {
  return const Center(child: Icon(Icons.broken_image, color: Colors.white38));
}
