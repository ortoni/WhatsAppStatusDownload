import 'package:flutter/material.dart';
import 'dart:io';
import 'package:whats_status/util.dart';

class StatusImages extends StatefulWidget {
  @override
  _StatusImagesState createState() => _StatusImagesState();
}

class _StatusImagesState extends State<StatusImages> {
  @override
  Widget build(BuildContext context) {
    List list = List();
    Set set = new Set();
    return FutureBuilder<Directory>(
        future: localFile,
        builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var file = snapshot.data;
              file.listSync().forEach((f) {
                //list.clear();
                if (f.path.endsWith('.jpg')) {
                  set.add(f.path);
                }
              });
              list.clear();
              list.addAll(set);
            } else if (snapshot.hasError) {
              print('object');
            }
          }

          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) {
                        return SimpleDialog(
                          contentPadding: EdgeInsets.all(0.0),
                          children: <Widget>[
                            Image.asset(list[index]),
                          ],
                        );
                      });
                },
                child: Card(
                    child: Image.asset(
                  list[index],
                  fit: BoxFit.cover,
                )),
              );
            },
          );
        });
  }
}
