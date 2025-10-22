# cinema

(work in progress!)

video asset playback and rendering package for Flutter. uses AVFoundation on iOS and macOS, media3 on Android. probably will use ffmpeg on Linux and Windows in the future.

this is being developed for use in my apps, so some of the API may be opinionated towards my use cases.

the goal is to have a package that can handle video playback, easy compression, video editing (trimming, concatenation, overlays, etc), and exporting in a simple and consistent API across all platforms that Flutter supports. the initial target is mobile (iOS and Android; macOS comes as a bonus). web is completely out of scope for now.
