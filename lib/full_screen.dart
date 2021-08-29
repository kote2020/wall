import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/painting/box_fit.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter/src/widgets/heroes.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;

  const FullScreen({Key key, this.imageUrl});

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  FToast fToast;
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast;
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  void _save(url) async {
    var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    var status = await Permission.photos.request();
    var name = new File(url);
    var name_right = basename(name.path);
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {}
    }
    if (status.isGranted) {
      return await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
          quality: 60, name: name_right.split(".").first);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<void> setWall() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    return await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: [
          new Container(
            //alignment: Alignment.center,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
//          Container(
//            child: Image.network(
//              widget.imageUrl,
//              fit: BoxFit.cover,
//            ),
//          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.white54,
                        shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: IconButton(
                      //padding: EdgeInsets.only(bottom: 20),
                      icon: Icon(
                        Icons.settings_overscan_rounded,
                      ),
                      //iconSize: 30,
                      onPressed: () {
                        setWall();

                        Future.delayed(const Duration(seconds: 1), () {
                          Fluttertoast.showToast(
                              msg: "Обои установлены",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.white54,
                        shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: IconButton(
                      //padding: EdgeInsets.only(bottom: 20),
                      icon: Icon(
                        Icons.save_alt_rounded,
                      ),
                      //iconSize: 30,
                      onPressed: () {
                        _save(widget.imageUrl);
                        Fluttertoast.showToast(
                            msg: "Обои сохранены",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.white54,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(30),
                    color: Colors.white54,
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: IconButton(
                  //padding: EdgeInsets.only(bottom: 20),
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  //iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
