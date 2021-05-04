//import 'dart:async';
//import 'dart:convert';
//
////import 'dart:html';
//import 'dart:typed_data';
//import 'dart:io';

//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;
//import 'package:image_gallery_saver/image_gallery_saver.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:wallpaper/wall.dart';
//import 'package:logger/logger.dart';
//import 'package:transparent_image/transparent_image.dart';
//import 'package:path/path.dart';
import 'package:wallpaper/wallpaper.dart';

//import { createClient } from 'pexels';
//
//const client = createClient('563492ad6f917000010000016358829a565746a6a562c1def989f72a');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wallpaper(),
    );
  }
}
