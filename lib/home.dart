import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/categories.dart';
import 'package:wallpaper/models/wallpaper.dart';
import 'package:wallpaper/walls.dart';

import 'models/category.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories;
  List<Wallpaper> walls;

  //ScrollController _scrollController = new ScrollController();

  int page = 1;

//  _loadMore() {
//    setState(() {
//      page = page + 1;
//    });
//    int size = 30;
//    //String url = 'https://wallpaper4k.ru/api/v1/wallpapers';
//    //fetchApi('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString());
//    String url = 'https://wallpaper4k.ru/api/v1/wallpapers?size=' +
//        size.toString() +
//        '&page=' +
//        page.toString();
//    http.get(Uri.parse(url)).then((response) {
//      Map result = jsonDecode(response.body);
//      setState(() {
//        walls.addAll(result['list']);
//      });
//    });
//  }

//  Future<List<Category>> fetchCategories(http.Client client) async {
//    print('fetch category');
//    final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/categories'));
//
//    //print(response.body.toString());
//    // Use the compute function to run parsePhotos in a separate isolate.
//    return parseCategories(response.body);
//  }
//
//  List<Category> parseCategories(String responseBody) {
//    print('parse category');
//    final parsed = jsonDecode(responseBody).cast<String, dynamic>();
//    print(parsed['list']);
//    return parsed['list'].map<Category>((json) => Category.fromJson(json)).toList();
//  }

  @override
  void initState() {
    fetchWallpaper(http.Client());
    fetchCategories(http.Client());
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//        print(_scrollController.position.pixels);
//        _loadMore();
//      }
//    });
    super.initState();
  }

//  @override
//  void dispose() {
//    _scrollController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallpaper2You',
          //'Radio',
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w300,
            color: Colors.blueGrey[800],
            //backgroundColor: Colors.red
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<List<Category>>(
                future: fetchCategories(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? CategoryList(categories: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
              FutureBuilder<List<Wallpaper>>(
                future: fetchWallpaper(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? WallpaperList(walls: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
