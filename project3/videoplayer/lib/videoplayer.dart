import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
class Videoplayer extends StatefulWidget {
  const Videoplayer({super.key});

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  final String videoUrl ="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

   
   @override
   void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
    ..initialize().then((_) {
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
     looping: true,
     autoPlay: true,
    );    
     setState(() {});

   });}
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const CircularProgressIndicator(),
      )
      






  
    );
  }
}