import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:whats_status/util.dart';

class StatusVideos extends StatefulWidget {
  @override
  _StatusVideosState createState() => _StatusVideosState();
}

class _StatusVideosState extends State<StatusVideos> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo(String path) {
    if (playerController == null) {
      playerController = VideoPlayerController.asset(path)
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        print('PLaying ************ ${playerController.value.isPlaying}');
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   playerController.removeListener(listener);
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   // playerController.setVolume(0.0);
  //   playerController.removeListener(listener);
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    List list = List();
    Set set = new Set();
    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: FutureBuilder<Directory>(
          future: localFile,
          builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var file = snapshot.data;
                file.listSync().forEach((f) {
                  //list.clear();
                  if (f.path.endsWith('.mp4')) {
                    //print(f.path);
                    set.add(f.path);
                  }
                });
                list.clear();
                list.addAll(set);
              } else if (snapshot.hasError) {
                print('error');
              }
            }
            return ListView.builder(
              itemCount: list.length,
              // itemCount: list.length <= 0 ? 0 : list.length,
              itemBuilder: (BuildContext context, int index) {
                //return Container(child: AssetVideo(list[index]));
                return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: GestureDetector(
                      onTap: () {
                        createVideo(list[index]);
                        playerController.play();
                        print('****************************${list[index]}');
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: (playerController != null
                              ? VideoPlayer(playerController)
                              : Container()),
                        ),
                      ),
                    ));
              },
            );
          }),
    );
  }
}

// return Column(children: <Widget>[
//   Center(
//       child: AspectRatio(
//           aspectRatio: 16 / 9,
//           child: Container(
//             child: (playerController != null
//                 ? VideoPlayer(
//                     playerController,
//                   )
//                 : Container()),
//           ))),
//   RaisedButton(
//     onPressed: () {
//       createVideo();
//       playerController.play();
//     },
//     child: Text('Play'),
//   )
// ]);
