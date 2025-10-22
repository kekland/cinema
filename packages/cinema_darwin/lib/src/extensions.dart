import 'package:cinema_core/cinema_core.dart';
import 'package:cinema_darwin/src/gen/darwin_bindings.dart';
import 'package:objective_c/objective_c.dart';

extension MediaExtensions on Media {
  AVAsset createAVAsset() {
    return switch (this) {
      FileMedia m => AVAsset.assetWithURL(NSURL.fileURLWithPath(m.path.toNSString())),
      NetworkMedia m => AVAsset.assetWithURL(NSURL.URLWithString(m.url.toNSString())!),
      // _ => throw UnsupportedError('Unsupported media type for AVAsset creation'),
    };
  }
}

class NSErrorException implements Exception {
  NSErrorException({required this.error});

  final NSError error;

  @override
  String toString() {
    return 'NSError: ${error.description}';
  }
}

extension NSErrorExtensions on NSError {
  String get description => localizedDescription.toDartString();
  String? get failureReason => localizedFailureReason?.toDartString();

  NSErrorException toException() {
    return NSErrorException(error: this);
  }
}
