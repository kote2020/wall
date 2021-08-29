//import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper/home.dart';
import 'package:wallpaper/models/wallpaper.dart';
import 'package:wallpaper/categories.dart';
import 'package:wallpaper/walls.dart';

import 'full_screen.dart';

Future<List<Wallpaper>> fetchWallpaperByCategory(int category_id, int page) async {
  print('fetch wall by cat');
  final response = await http.get(Uri.parse('https://wallpaper4k'
          '.ru/api/v1/wallpapers?category_id=' +
      category_id.toString() +
      '&size=20&page=' +
      page.toString()));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseWallpaper(response.body);
}

List<Wallpaper> parseWallpaper(String responseBody) {
  print('parse wall by cat');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  print(parsed['list']);
  return parsed['list'].map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
}

class WallCategory extends StatefulWidget {
  final int category_id;

  WallCategory({Key key, this.category_id}) : super(key: key);

  @override
  _WallCategoryState createState() => _WallCategoryState();
}

class _WallCategoryState extends State<WallCategory> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWallpaperByCategory(5, 2);
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(7, 0, 7, 20),

      crossAxisCount: 4,
      itemBuilder: (context, index) {
        String imgPath = '';
        return new Material(
            elevation: 3.0,
            borderRadius: new BorderRadius.circular(8.0),
            shadowColor: Colors.grey.shade50,
            child: new InkWell(
              onTap: () => Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new FullScreen(imageUrl: imgPath))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: new FadeInImage(
//placeholder: 'assets/images/loading.gif',
                  placeholder: new AssetImage('assets/images/load_sm.gif'),
                  image: NetworkImage(
                    imgPath,
                  ),
                  fit: BoxFit.cover,
//fadeInDuration: Duration.millisecondsPerDay,
                ),
              ),
            ));
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 7.0,
      crossAxisSpacing: 7.0,
    );
  }
}
