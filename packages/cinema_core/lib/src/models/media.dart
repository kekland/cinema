sealed class Media {
  const Media();
  factory Media.file(String path) = FileMedia;
  factory Media.network(String url) = NetworkMedia;
}

final class FileMedia extends Media {
  const FileMedia(this.path);

  final String path;
}

final class NetworkMedia extends Media {
  const NetworkMedia(this.url);

  final String url;
}
