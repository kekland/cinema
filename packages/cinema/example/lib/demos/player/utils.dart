import 'package:flutter/material.dart';

Future<String?> showVideoUrlInputDialog(BuildContext context) async {
  final url = await showDialog<String>(
    context: context,
    builder: (context) {
      String input = '';
      return AlertDialog(
        title: Text('Enter video URL'),
        content: TextField(
          onChanged: (value) {
            input = value;
          },
          decoration: InputDecoration(hintText: "https://example.com/video.mp4"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(input),
            child: Text('OK'),
          ),
        ],
      );
    },
  );

  return url;
}

const _presets = {
  'Big Buck Bunny': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  'Elephants Dream': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'For Bigger Blazes': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  'Sintel': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
};

Future<String?> showVideoPresetsDialog(BuildContext context) async {
  final preset = await showDialog<String>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text('Select a video preset'),
        children: _presets.entries.map((entry) {
          return SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(entry.value),
            child: Text(entry.key),
          );
        }).toList(),
      );
    },
  );

  return preset;
}
