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

//
//  ScrollController _scrollController = new ScrollController();
//
//  int page = 1;

  @override
  void initState() {
    fetchWallpaper();
    fetchCategories(http.Client());

    super.initState();
  }

//  _loadMore() {
//    setState(() {
//      page = page + 1;
//    });
//    int size = 30;
//    String url = 'https://wallpaper4k.ru/api/v1/wallpapers?size=' +
//        size.toString() +
//        '&page=' +
//        page.toString();
//    //fetchApi('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString());
//    //String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
//    http.get(Uri.parse(url)).then((response) {
//      Map result = jsonDecode(response.body);
//      setState(() {
//        walls.addAll(result['list']);
//      });
//    });
//  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              future: fetchWallpaper(),
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
    );
  }
}
