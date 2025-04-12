import 'package:flutter/material.dart';
import '../data/movie.dart';
import 'package:provider/provider.dart';
import '../providers/rentedmovieprovider.dart';
import 'package:video_player/video_player.dart';

class WatchPage extends StatefulWidget {
  final Movie movie;

  const WatchPage({super.key, required this.movie});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late final RentedMovieProvider rentedProvider;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    rentedProvider = Provider.of<RentedMovieProvider>(context, listen: false);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4'),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [
          IconButton(
            icon: Icon(Icons.visibility_off,
                color: Theme.of(context).colorScheme.error),
            tooltip: 'Mark as Watched',
            onPressed: () {
              rentedProvider.removeMovieById(widget.movie.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
