import 'dart:convert';
import 'dart:developer';
import 'dart:math';

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

  List images = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  String url = 'https://wallpaper4k.ru/api/v1/wallpapers?size=20&page=';

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('get more');
        //loadMore();
      }
    });
  }

  fetchApi(page) async {
    await http.get(Uri.parse(url + page)).then((value) {
      //print(value.body);
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['list'];
      });
      //print(images);
    });
  }

  loadMore() async {
    int size = 20;
    int page = currentPage + 1;
    var uri = 'https://wallpaper4k.ru/api/v1/wallpapers' +
        '?size=' +
        size.toString() +
        '&page=' +
        page.toString();

    await http.get(Uri.parse(uri)).then((value) {
      print(value.body);
      Map result = jsonDecode(value.body);
      setState(() {
        walls.addAll(result['list']);
      });
    });

    //print(walls);

//    await http.get(Uri.parse(uri)).then((value) {
//      //print(value.body);
//      Map result = jsonDecode(value.body);
//      walls.addAll(result['list']);
//    });

    //fetchApi('https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString());
    //String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    //fetchWallpaper(url);

//    http.get(Uri.parse(url)).then((response) {
//      Map result = jsonDecode(response.body);
//       walls.addAll(result['list']);
//    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Wallpaper2You',
              //'Radio',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w300,
                color: Colors.blueGrey[800],
                //backgroundColor: Colors.red
              ),
            ),
          ],
        ),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
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

//              InkWell(
//                onTap: () {
//                  loadMore();
//                },
//                child: Container(
//                  height: 60,
//                  width: double.infinity,
//                  color: Colors.black,
//                  child: Center(
//                    child: Text(
//                      'Load More',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  ),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
