import 'package:cinema/cinema.dart';
import 'package:example/demos/player/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PlayerDemo extends StatefulWidget {
  const PlayerDemo({super.key});

  @override
  State<PlayerDemo> createState() => PlayerDemoState();
}

class PlayerDemoState extends State<PlayerDemo> {
  final player = VideoPlayer();
  Media? _media;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _selectFileMedia() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.length == 1) {
      final file = result.files.single;
      _media = Media.file(file.path!);
      player.setMedia(_media!);
      setState(() {});
    }
  }

  Future<void> _selectNetworkMedia() async {
    final url = await showVideoUrlInputDialog(context);

    if (url != null && url.isNotEmpty) {
      _media = Media.network(url);
      player.setMedia(_media!);
      setState(() {});
    }
  }

  Future<void> _selectPresetNetworkMedia() async {
    final url = await showVideoPresetsDialog(context);

    if (url != null && url.isNotEmpty) {
      _media = Media.network(url);
      player.setMedia(_media!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_media);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OverflowBar(
              spacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: _selectFileMedia,
                  child: Text('Select file'),
                ),
                ElevatedButton(
                  onPressed: _selectNetworkMedia,
                  child: Text('Enter network URL'),
                ),
                ElevatedButton(
                  onPressed: _selectPresetNetworkMedia,
                  child: Text('Select preset video'),
                ),
              ],
            ),
          ),
          Expanded(
            child: VideoPlayerWidget(
              player: player,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: player.play,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: player.pause,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
