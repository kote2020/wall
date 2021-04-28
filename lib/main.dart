import 'dart:async';
import 'dart:convert';

//import 'dart:html';
import 'dart:typed_data';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/wall.dart';
import 'package:logger/logger.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:path/path.dart';

void main() => runApp(MyHomePage());

//List<Wall> wall;

Future<List<Wall>> fetchImages(http.Client client) async {
  print('fetch');
  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));

  final infoImage = json.decode(response.body);

  Map<String, dynamic> data = new Map<String, dynamic>.from(infoImage);
  print(data['list']);
  //print(infoImage["list"][6]['image']['url']);

  //wall = parseImages(response.body);
  //print(wall);
  //print(infoImage['list']);
  //final ticketModelFromJson = Wall.fromJson(infoImage);

  return compute(parseImages, response.body);
}

List<Wall> parseImages(String responseBody) {
  print('parse');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();

  //final get = parsed['list'];
  //print(parsed['list']);
  return parsed['list'].map<Wall>((json) => Wall.fromJson(json)).toList();
  //  return parsed['items']
//      .map<Station>((json) => Station.fromJson(json))
//      .toList();
}

//Future<List<Wall>> fetchImages(http.Client client) async {
//  print('fetch');
//  final response =
//      await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));
//  //List<Wall> images = imageObjsJson.map((tagJson) => Wall.fromJson(tagJson)).toList();
//
//  //List<dynamic> data = map["list"];
//  //final infoImage = json.decode(response.body);
//
//  //image = infoImage['image'];
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parseImages, response.body);
//}

//Future<List<Station>> fetchStations(http.Client client) async {
//  print('fetch');
//  final response = await client
//      .get(Uri.parse('https://radio.bobrilka.ru/api/radio-stations'));
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parseStation, response.body);
//}

//A function that converts a response body into a List<Photo>.
//List<Wall> parseImages(String responseBody) {
//  Map image;
//  print('parse');
//  //Wall wall = Wall.fromJson(jsonDecode(responseBody));
//  final parsed = jsonDecode(responseBody).cast<String, dynamic>() as List;
//  //final image = jsonDecode(responseBody)['list'] as List;
//  print(parsed);
//  //print(parsed['list']);
//  return parsed.map<Wall>((json) => Wall.fromJson(json)).toList();
//}

//List<Station> parseStation(String responseBody) {
//  print('parse');
//  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
//  //print(parsed['items']);
//  return parsed['items']
//      .map<Station>((json) => Station.fromJson(json))
//      .toList();
//}

class MyHomePage extends StatelessWidget {
  final List<Wall> images;

  //final List<Wall> stations;

  //MyHomePage({Key key, this.images}) : super(key: key);
  MyHomePage({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Wallpaper2You',
            //'Radio',
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder<List<Wall>>(
          future: fetchImages(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ImageList(images: snapshot.data)
                : Center(child: Text('loading...'));
          },
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}

void _save(url) async {
  var response =
      await Dio().get(url, options: Options(responseType: ResponseType.bytes));
  var status = await Permission.photos.request();
  var name = new File(url);
  var name_right = basename(name.path);
  if (Platform.isAndroid) {
    if (await _requestPermission(Permission.storage)) {
      if (status.isGranted) {
        return await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: name_right.split(".").first);
      }
    }
  }

  //print(result);
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

class ImageList extends StatelessWidget {
  final List<Wall> images;

  ImageList({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: EdgeInsets.all(5),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            //_save("${stations[index].icon}");
            //_save("${images[index].id}");
            print('save -> ' + " ${images[index].id}");
          },
          child: Container(
            width: 200,
            margin: EdgeInsets.all(6),
            child: Text('hello'),
          ),
        );
      },
    );
  }

//class StationList extends StatelessWidget {
//  final List<Station> stations;
//
//  StationList({Key key, this.stations}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//      ),
//      padding: EdgeInsets.all(5),
//      itemCount: stations.length,
//      itemBuilder: (context, index) {
//        return InkWell(
//          onTap: () {
//            //_save("${stations[index].icon}");
//            _save("${stations[index].icon}");
//            print('save -> ' + " ${stations[index].icon}");
//          },
//          child: Container(
//            width: 200,
//            margin: EdgeInsets.all(6),
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(7),
//              child: FadeInImage.memoryNetwork(
//                placeholder: kTransparentImage,
//                image: "${stations[index].icon}",
//                //fadeInDuration: Duration.millisecondsPerDay,
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
}
