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

import 'full_screen.dart';

Future<List<Wallpaper>> fetchWallpaper(String url) async {
  print('fetch wall');
  final response = await http.get(Uri.parse(url));
  return compute(parseWallpaper, response.body);
}

List<Wallpaper> parseWallpaper(String responseBody) {
  print('parse wall');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  // print(parsed['list']);
  return parsed['list'].map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
}

class WallpaperList extends StatefulWidget {
  final List<Wallpaper> walls;

  WallpaperList({Key key, this.walls}) : super(key: key);

  @override
  _WallpaperListState createState() => _WallpaperListState();
}

class _WallpaperListState extends State<WallpaperList>
    with AutomaticKeepAliveClientMixin<WallpaperList> {
  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('get more');
        //loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(7, 0, 7, 20),
      itemCount: widget.walls.length + 1,
      crossAxisCount: 4,
      itemBuilder: (context, index) {
        if (index == widget.walls.length) {
          return CupertinoActivityIndicator();
        } else {
          String imgPath = widget.walls[index].image.url;
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
        }
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 7.0,
      crossAxisSpacing: 7.0,
    );
  }
}
