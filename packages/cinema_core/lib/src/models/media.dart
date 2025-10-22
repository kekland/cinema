sealed class Media {
  const Media();
  factory Media.file(String path) = FileMedia;
  factory Media.network(String url) = NetworkMedia;
}

final class FileMedia extends Media {
  const FileMedia(this.path);

  final String path;

  @override
  String toString() => 'FileMedia[$path]';

  @override
  bool operator ==(Object other) => identical(this, other) || (other is FileMedia && path == other.path);

  @override
  int get hashCode => path.hashCode;
}

final class NetworkMedia extends Media {
  const NetworkMedia(this.url);

  final String url;

  @override
  String toString() => 'NetworkMedia[$url]';

  @override
  bool operator ==(Object other) => identical(this, other) || (other is NetworkMedia && url == other.url);

  @override
  int get hashCode => url.hashCode;
}
