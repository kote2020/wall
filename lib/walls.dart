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
import 'package:wallpaper/models/wallpaper.dart';

import 'full_screen.dart';

Future<List<Wallpaper>> fetchWallpaper() async {
  print('fetch wall');
  final response = await http.get(Uri.parse('https://wallpaper4k'
      '.ru/api/v1/wallpapers?size=20'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseWallpaper, response.body);
}

List<Wallpaper> parseWallpaper(String responseBody) {
  print('parse wall');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  // print(parsed['list']);
  return parsed['list'].map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
}

class WallpaperList extends StatelessWidget {
  final List<Wallpaper> walls;

  WallpaperList({Key key, this.walls}) : super(key: key);

  ScrollController _scrollController = ScrollController();
  int currentMax = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: ListView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: walls.length,
            itemBuilder: (context, i) {
              return SizedBox(width: 100, height: 50, child: Text(walls[i].category.ru));
            },
          ),
        ),
        new StaggeredGridView.countBuilder(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          physics: BouncingScrollPhysics(),
          itemCount: walls.length,
          crossAxisCount: 4,
          itemBuilder: (context, index) {
//        if (index == walls.length) {
//          return CupertinoActivityIndicator();
//        }
            String imgPath = walls[index].image.url;
            return new Material(
                elevation: 3.0,
                borderRadius: new BorderRadius.circular(8.0),
                shadowColor: Colors.grey.shade50,
                child: new InkWell(
                  onTap: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new FullScreen(imageUrl: imgPath))),
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
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ],
    );
  }
}
