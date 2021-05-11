//import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper/models/wallpaper.dart';

import 'full_screen.dart';

Future<List<Wallpaper>> fetchWallpaper(http.Client client) async {
  print('fetch wall');
  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseWallpaper, response.body);
}

List<Wallpaper> parseWallpaper(String responseBody) {
  print('parse wall');
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  print(parsed['list']);
  return parsed['list'][0].map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
}

class WallpaperList extends StatelessWidget {
  final List<Wallpaper> walls;

  //List<Wallpaper> wallpapers = new List();

  WallpaperList({Key key, this.walls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: ScrollController(initialScrollOffset: 70),
        physics: BouncingScrollPhysics(),
//        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(5),
        itemCount: walls.length,
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
                  child: Text('${walls[index].id}'),
//                  child: FadeInImage.memoryNetwork(
//                    placeholder: kTransparentImage,
//                    image: walls[index].icon,
//                    //fadeInDuration: Duration.millisecondsPerDay,
////                ),
//                  ),
                ),
              ));
        });

//    return Container(
//      height: 70,
//      child: GridView.builder(
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2,
//          ),
//          padding: EdgeInsets.symmetric(horizontal: 15),
////      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////        crossAxisCount: 2,
////      ),
//          shrinkWrap: true,
//          scrollDirection: Axis.horizontal,
//          itemCount: walls.length,
//          itemBuilder: (context, index) {
//            return Container(
//                margin: EdgeInsets.only(right: 10, top: 10),
//                //padding: EdgeInsets.symmetric(horizontal: 10),
//                child: Stack(
//                  children: [
//                    SizedBox(
//                      //height: 30,
//                      //width: double.infinity,
//                      child: Container(
//                          color: Colors.red,
//                          width: 110,
//                          height: 30,
//                          alignment: Alignment.center,
//                          padding: EdgeInsets.symmetric(horizontal: 5),
//                          child: new FadeInImage(
////placeholder: 'assets/images/loading.gif',
//                            placeholder: new AssetImage('assets/images/load_sm.gif'),
//                            image: new NetworkImage(walls[index].icon),
//                            fit: BoxFit.cover,
////fadeInDuration: Duration.millisecondsPerDay,
//                          )
////                        child: FittedBox(
////                          fit: BoxFit.fill,
////                          child: Text(
////                            walls[index].name,
////                            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400),
////                          ),
////                        ),
//                          ),
//                    ),
//                  ],
//                ));
//            //return Text(categories[index].name.ru);
//          }),
//    );
//    return new StaggeredGridView.countBuilder(
//      controller: ScrollController(),
//      physics: BouncingScrollPhysics(),
//      //controller: _scrollController,
////reverse: true,
//      shrinkWrap: true,
//
//      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
//      //physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//      itemCount: walls.length,
//      crossAxisCount: 4,
//      itemBuilder: (context, index) {
//        String imgPath = walls[index].icon;
//        print(imgPath);
//        return new Material(
//            elevation: 3.0,
//            borderRadius: new BorderRadius.circular(8.0),
//            shadowColor: Colors.grey.shade50,
//            child: new InkWell(
//              onTap: () => Navigator.push(context,
//                  new MaterialPageRoute(builder: (context) => new FullScreen(imageUrl: imgPath))),
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(8.0),
//                child: new Hero(
//                  tag: 'tagImage$index',
//                  child: new FadeInImage(
////placeholder: 'assets/images/loading.gif',
//                    placeholder: new AssetImage('assets/images/load_sm.gif'),
//                    image: new NetworkImage(imgPath),
//                    fit: BoxFit.cover,
////fadeInDuration: Duration.millisecondsPerDay,
//                  ),
//                ),
//              ),
//            ));
//      },
//      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 3),
//      mainAxisSpacing: 10.0,
//      crossAxisSpacing: 10.0,
//    );
  }
}
