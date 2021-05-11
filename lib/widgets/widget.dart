import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/models/wallpaper.dart';

import '../full_screen.dart';

Widget WallpaperList({List<Wallpaper> wallpapers, context}) {
  return new StaggeredGridView.countBuilder(
    //controller: _scrollController,
//reverse: true,
//shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    itemCount: wallpapers.length + 1,
    crossAxisCount: 4,
    itemBuilder: (context, index) {
      if (index == wallpapers.length) {
        return CupertinoActivityIndicator();
      }
      String imgPath = wallpapers[index].image.url;
      return new Material(
          elevation: 3.0,
          borderRadius: new BorderRadius.circular(8.0),
          shadowColor: Colors.grey.shade50,
          child: new InkWell(
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new FullScreen(imageUrl: wallpapers[index].image.url))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: new Hero(
                tag: 'tagImage$index',
                child: new FadeInImage(
//placeholder: 'assets/images/loading.gif',
                  placeholder: new AssetImage('assets/images/load_sm.gif'),
                  image: new NetworkImage(imgPath),
                  fit: BoxFit.cover,
//fadeInDuration: Duration.millisecondsPerDay,
                ),
              ),
            ),
          ));
    },
    staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 3),
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
  );
}
