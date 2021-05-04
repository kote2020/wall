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
import 'package:wallpaper/wall.dart';

Future<List<Wall>> fetchImages(http.Client client) async {
  print('fetch');
  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseImages, response.body);
}

List<Wall> parseImages(String responseBody) {
  print('parse');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print(parsed['list']);
  return parsed['list'].map<Wall>((json) => Wall.fromJson(json)).toList();
}

class Wallpaper extends StatefulWidget {
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];

  List<Wall> _images = [];
  int page = 1;
  bool _loading = false;
  ScrollController _scrollController = new ScrollController();
  final String url = 'https://wallpaper4k.ru/api/v1/wallpapers';

  @override
  void initState() {
    super.initState();
    fetchImages(http.Client());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);
//        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

//
//  fetchApi() async {
//    //var url = 'https://api.pexels.com/v1/curated?per_page=80';
//    //var size = 30;
//    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=1'), headers: {
//      'Authorization': '563492ad6f917000010000016358829a565746a6a562c1def989f72a',
//    }).then((response) {
//      print('body' + response.body);
//      //print(response.X-Ratelimit-Limit);
//
//      Map result = jsonDecode(response.body);
//      setState(() {
//        images = result['photos'];
//      });
//      //print(images.length);
//      //print(result);
//    });
//  }

//
//  _loadMore() {
//    setState(() {
//      page = page + 1;
//    });
//    int size = 30;
//    //String url = 'https://wallpaper4k.ru/api/v1/wallpapers';
//    //fetchApi('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString());
//    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
//    http.get(Uri.parse(url), headers: {
//      'Authorization': '563492ad6f917000010000016358829a565746a6a562c1def989f72a'
//    }).then((response) {
//      Map result = jsonDecode(response.body);
//      setState(() {
//        images.addAll(result['photos']);
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    Timer(
//      Duration(seconds: 2),
//      () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
//    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(5),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Text("${_images[index].id}");
        },
      ),
    );
  }
}
