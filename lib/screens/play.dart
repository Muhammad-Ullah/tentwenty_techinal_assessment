import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constant/trending.dart';

class Play extends StatefulWidget {

  final String videoKey;

  const Play({Key? key,required this.videoKey}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {

  Future<Upcoming> fetchMovieDetail() async {
    print("play screens id: ${widget.videoKey}");
    final response = await http
        .get(Uri.parse("https://api.themoviedb.org/3/movie/${widget.videoKey}/videos?api_key=3b83ef7227c10c65c365801b3a5c4c00"));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return Upcoming.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the Upcoming Movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchMovieDetail(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset('assets/images/loading.gif'),
            );
          } else {
            return HorizontalCards(movieData:snapshot.data.movies);
          }
        },
      ),
    );
  }
}


class HorizontalCards extends StatelessWidget {
  final List movieData;
  const HorizontalCards({Key? key,required this.movieData}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return SizedBox(
      height: h* 0.99,
      child: ListView.builder(
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          return (index!=0)?Container():InkWell(
            onTap: (){
              print("key is: ${'https://www.youtube.com/watch?v=${movieData[index]['key']}'}");
            },
            child: Container(
              width: w * 0.45,
              height: h * 0.55,
              margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: VideoPlayerScreen(videoId: movieData[index]['key'],),
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String? videoId;

  const VideoPlayerScreen({Key? key, @required this.videoId}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    print("videoId is: ${widget.videoId}");
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )
      ..addListener(listener);
  }

  void listener() {
    if (_controller?.value.errorCode != null) {
      print("error: ${_controller?.value.errorCode}");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
              onEnded: (data) {
                Navigator.of(context).pop();
                _controller!
                  ..load(widget.videoId ?? "")
                  ..play();
              },
            ),
            // Text('${_controller!.metadata.duration.inSeconds}'),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                if(_controller!.value.isPlaying){
                  _controller!.pause();
                }
                else{
                  _controller!.play();
                }
              },
              child: Container(
                width:0.95*h,
                padding: EdgeInsets.all(w*0.05),
                color: Colors.blueGrey,
                alignment: Alignment.bottomCenter,
                child:Text( _controller!.value.isPlaying?"Pause":"Play",style: TextStyle(fontSize: 20),) ,
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                  _controller!.toggleFullScreenMode();
              },
              child: Container(
                width:0.95*h,
                padding: EdgeInsets.all(w*0.05),
                color: Colors.blueGrey,
                alignment: Alignment.bottomCenter,
                child:const Text("Full Screen",style: TextStyle(fontSize: 20),) ,
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width:0.95*h,
                padding: EdgeInsets.all(w*0.05),
                color: Colors.blueGrey,
                alignment: Alignment.bottomCenter,
                child:const Text("Done",style: TextStyle(fontSize: 20),) ,
              ),
            )
          ],
        ),
      ),
    );
  }
}