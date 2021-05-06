import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:path/path.dart';
import 'package:wallpaper/full_screen.dart';
import 'package:flutter/src/widgets/heroes.dart';
import 'package:wallpaper/station.dart';
import 'package:wallpaper/wall.dart';

final List<Station> stations = [];
final List<Wall> images = [];

//Future<List<Station>> fetchStations(http.Client client) async {
//  print('fetch');
//  final response = await client.get(Uri.parse('https://radio.bobrilka.ru/api/radio-stations'));
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parseStation, response.body);
//}
//
//List<Station> parseStation(String responseBody) {
//  print('parse');
//  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
//  print(parsed['items']);
//  return parsed['items'].map<Station>((json) => Station.fromJson(json)).toList();
//}

//A function that converts a response body into a List<Photo>.
List<Wall> parseImages(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Wall>((json) => Wall.fromJson(json)).toList();
}

Future<List<Wall>> fetchImages(http.Client client) async {
  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));

  return parseImages(response.body);
}

Future _getData() async {
  var data = await http.get(Uri.parse("https://wallpaper4k.ru/api/v1/wallpapers"));
  var jsonData = json.decode(data.body);
  print(jsonData['list']);

  return jsonData['list'][0];
}

// A function that converts a response body into a List<Photo>.
//List<Photo> parsePhotos(String responseBody) {
//  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//
//  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
//}
//
//Future<List<Photo>> fetchPhotos(http.Client client) async {
//  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//
//  return parsePhotos(response.body);
//}

class Wallpapers extends StatelessWidget {
  //final List<Station> stations;

  final List<Wall> walls;

  //Wallpapers({Key key, this.stations}) : super(key: key);

  Wallpapers({Key key, this.walls}) : super(key: key);

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
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.all(5),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //_save("${stations[index].icon}");
                          //_save("${stations[index].icon}");
                          //print('save -> ' + " ${images[index].id}");
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Center(child: Text('${walls[index].image.url}')),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
            return snapshot.hasData
                ? ImageList(images: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}

//class Wallpaper extends StatefulWidget {
//  _WallpaperState createState() => _WallpaperState();
//}
//
//class _WallpaperState extends State<Wallpaper> {
//  //Future<Wall> futureList;
//  List images = [];
//
//  List<Wall> _images = [];
//  int page = 1;
//  bool _loading = false;
//  ScrollController _scrollController = new ScrollController();
//  final String url = 'https://wallpaper4k.ru/api/v1/wallpapers';
//
//  @override
//  void initState() {
//    super.initState();
//    //fetchImages(http.Client());
//    //fetchImages(http.Client());
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//        print(_scrollController.position.pixels);
////        _loadMore();
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    _scrollController.dispose();
//    super.dispose();
//  }
//
////
////  fetchApi() async {
////    //var url = 'https://api.pexels.com/v1/curated?per_page=80';
////    //var size = 30;
////    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=1'), headers: {
////      'Authorization': '563492ad6f917000010000016358829a565746a6a562c1def989f72a',
////    }).then((response) {
////      print('body' + response.body);
////      //print(response.X-Ratelimit-Limit);
////
////      Map result = jsonDecode(response.body);
////      setState(() {
////        images = result['photos'];
////      });
////      //print(images.length);
////      //print(result);
////    });
////  }
//
////
////  _loadMore() {
////    setState(() {
////      page = page + 1;
////    });
////    int size = 30;
////    //String url = 'https://wallpaper4k.ru/api/v1/wallpapers';
////    //fetchApi('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString());
////    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
////    http.get(Uri.parse(url), headers: {
////      'Authorization': '563492ad6f917000010000016358829a565746a6a562c1def989f72a'
////    }).then((response) {
////      Map result = jsonDecode(response.body);
////      setState(() {
////        images.addAll(result['photos']);
////      });
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
////    Timer(
////      Duration(seconds: 2),
////      () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
////    );
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: FutureBuilder<List<Wall>>(
//        //future: fetchImages(http.Client()),
//        builder: (context, snapshot) {
//          if (snapshot.hasError) print(snapshot.error);
//          //print(snapshot.data);
//          return snapshot.hasData
//              ? ImageList(images: snapshot.data)
//              : Center(child: Text('loading...'));
//        },
//      ),
//    );
//  }
//}

//class PhotosList extends StatelessWidget {
//  final List<Photo> photos;
//
//  PhotosList({Key key, this.photos}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//      ),
//      itemCount: photos.length,
//      itemBuilder: (context, index) {
//        return InkWell(
//          onTap: () {
//            //_save("${stations[index].icon}");
//            //_save("${stations[index].icon}");
//            print('save -> ' + " ${photos[index].thumbnailUrl}");
//          },
//          child: Container(
//            width: 200,
//            margin: EdgeInsets.all(6),
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(7),
//              child: FadeInImage.memoryNetwork(
//                placeholder: kTransparentImage,
//                image: "${photos[index].thumbnailUrl}",
//                //fadeInDuration: Duration.millisecondsPerDay,
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}

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
              //_save("${stations[index].icon}");
              //print('save -> ' + " ${images[index].id}");
            },
            child: Container(
              width: 200,
              margin: EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Text('${images[index].id}'),
//                child: FadeInImage.memoryNetwork(
//                  placeholder: kTransparentImage,
//                  image: "${images[index].thumbnailUrl}",
//                  //fadeInDuration: Duration.millisecondsPerDay,
//                ),
              ),
            ),
          );
        });
  }
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
//            //_save("${stations[index].icon}");
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
//}
