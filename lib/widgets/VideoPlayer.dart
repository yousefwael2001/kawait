import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFromUrl extends StatefulWidget {
  const VideoPlayerFromUrl(
      {super.key, required this.videoUrl, required this.dataSourceType});
  final String videoUrl;
  final DataSourceType dataSourceType;
  @override
  State<VideoPlayerFromUrl> createState() => _VideoPlayerFromUrlState();
}

class _VideoPlayerFromUrlState extends State<VideoPlayerFromUrl> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;

  @override
  void initState() {
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _controller = VideoPlayerController.asset(widget.videoUrl);
        break;
      case DataSourceType.network:
        _controller = VideoPlayerController.network(widget.videoUrl);
        break;
      case DataSourceType.file:
        _controller = VideoPlayerController.file(File(widget.videoUrl));
        break;
      case DataSourceType.contentUri:
        _controller =
            VideoPlayerController.contentUri(Uri.parse(widget.videoUrl));
        break;
    }
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
