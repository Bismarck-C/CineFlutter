import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class TrailerPlayer extends StatefulWidget {
  final String url;

  const TrailerPlayer({super.key, required this.url});

  @override
  TrailerPlayerState createState() => TrailerPlayerState();
}

class TrailerPlayerState extends State<TrailerPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        print('Listo para reproducir.');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}