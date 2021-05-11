import 'dart:async';
import 'dart:convert';
import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/models/category.dart';
import 'package:wallpaper/models/wallpaper.dart';
import 'package:wallpaper/wallpaper.dart';

import 'full_screen.dart';

//Future<Category> fetchCategories (http.Client client) async {
//  final response = await http.get(Uri.parse('https://wallpaper4k.ru/api/v1/categories'));
//}

Future<List<Category>> fetchCategories(http.Client client) async {
  print('fetch category');
  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/categories'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseCategories(response.body);
}

List<Category> parseCategories(String responseBody) {
  print('parse category');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  //print(parsed['items']);
  return parsed['list'].map<Category>((json) => Category.fromJson(json)).toList();
}

class Categories extends StatefulWidget {
  //List<Category> categories = new List();
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Wallpaper> walls = [];

  Future<List<Wallpaper>> fetchWallpaperByCategory(int category_id) async {
    print('fetch wall by cat');
    final response = await http.get(Uri.parse('https://wallpaper4k'
            '.ru/api/v1/wallpapers?category_id=' +
        category_id.toString()));

    // Use the compute function to run parsePhotos in a separate isolate.
    return parseWallpaper(response.body);
  }

  List<Wallpaper> parseWallpaper(String responseBody) {
    print('parse wall');
    final parsed = jsonDecode(responseBody).cast<String, dynamic>();
    print(parsed['items']);
    return parsed['items'].map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
      body: FutureBuilder<List<Category>>(
        future: fetchCategories(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? CategoryList(categories: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//color: Colors.primaries[Random().nextInt(Colors.primaries.length)],

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  List colors = [
    Colors.pink[100],
    Colors.red[100],
    Colors.deepOrange[100],
    Colors.orange[100],
    Colors.amber[100],
    Colors.yellow[100],
    Colors.lime[100],
    Colors.lightGreen[100],
    Colors.green[100],
    Colors.teal[100],
    Colors.lightBlue[100],
    Colors.blue[100],
    Colors.indigo[100],
    Colors.purple[100],
    Colors.deepPurple[100],
    Colors.blueGrey[100],
    Colors.grey[100],
    Colors.brown[100],
  ];
  List borders = [
    Colors.pink[400],
    Colors.red[400],
    Colors.deepOrange[400],
    Colors.orange[700],
    Colors.amber[700],
    Colors.yellow[700],
    Colors.lime[700],
    Colors.lightGreen[700],
    Colors.green[700],
    Colors.teal[400],
    Colors.lightBlue[400],
    Colors.blue[400],
    Colors.indigo[400],
    Colors.purple[400],
    Colors.deepPurple[400],
    Colors.blueGrey[400],
    Colors.grey[400],
    Colors.brown[400],
  ];

  //List<Wallpaper> wallpapers = new List();

  CategoryList({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//      ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,

        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              //padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 1),
                      width: 110,
                      height: 30,
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(color: colors[index]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    //height: 30,
                    //width: double.infinity,
                    child: Container(
                      width: 110,
                      height: 30,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          categories[index].name.ru,
                          style: TextStyle(color: borders[index], fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
//                  WallpaperList(walls: wallpapers)
                ],
              ));
          //return Text(categories[index].name.ru);
        },
      ),
    );
  }
}
