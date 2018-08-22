import 'package:flutter/material.dart';
import 'package:whats_status/images.dart';
import 'package:whats_status/videos.dart';
import 'package:flutter/services.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() => runApp(new WhatsHome());

class WhatsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Status',
      //theme: new ThemeData(primaryColor: Colors.black),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _platformVersion = 'Unknown';
  Permission permission;
  bool res;

  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  requestPermission() async {
    res = await SimplePermissions.requestPermission(
        Permission.ReadExternalStorage);
    print("permission request result is " + res.toString());
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: false,
        child: Text('Videos'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return StatusVideos();
          }));
        },
      ),
      appBar: AppBar(
        title: Text('Status'),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      body: StatusImages(),
    );
  }
}
