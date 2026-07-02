/// Types of files that can be selected.
enum FileType {
  /// Any file.
  any,
  /// Media files.
  media,
  /// Image files.
  image,
  /// Video files.
  video,
  /// Audio files.
  audio,
  /// Custom file extension list.
  custom,
}

/// Represents a selected file on platforms where file picker is web/stub.
class PlatformFile {
  /// Local file system path.
  final String? path;
  /// Name of the file.
  final String name;
  /// Size of the file in bytes.
  final int size;
  /// Binary content of the file.
  final dynamic bytes;

  /// Creates a [PlatformFile].
  PlatformFile({
    this.path,
    required this.name,
    required this.size,
    this.bytes,
  });
}

/// Result object returned by the file picker.
class FilePickerResult {
  /// Selected files.
  final List<PlatformFile> files;
  /// Creates a [FilePickerResult].
  FilePickerResult(this.files);
}
