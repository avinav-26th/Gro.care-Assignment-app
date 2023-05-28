import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.shortsUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  int tapCount = 0;
  bool playIconVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          tapCount++;
        });
        if (tapCount % 2 == 0) {
          videoPlayerController.play();
          setState(() {
            playIconVisible = true;
          });
        } else {
          videoPlayerController.pause();
          setState(() {
            playIconVisible = false;
          });
        }
      },
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.greenAccent,
        child: Stack(
          alignment: Alignment.topRight,
            children: [
          VideoPlayer(videoPlayerController),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
            child: (playIconVisible)? const Icon(Icons.play_circle_outline_rounded): const Icon(Icons.pause_circle_outline_outlined),
          ),
        ]),
      ),
    );
  }
}
