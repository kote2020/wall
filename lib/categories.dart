import 'dart:async';
import 'dart:convert';
import 'dart:math';

//import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/models/category.dart';
import 'package:wallpaper/models/wallpaper.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper/walls.dart';

import 'full_screen.dart';

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
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categories;

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
      body: CategoryList(categories: categories),
    );
  }
}

class CategoryList extends StatefulWidget {
  final List<Category> categories;

  CategoryList({Key key, this.categories}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<CategoryList> {
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

  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    fetchWallpaper('https://wallpaper4k.ru/api/v1/wallpapers?size=20');
    _tabController = TabController(length: widget.categories.length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only( bottom: 15),
          child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: colors[15],
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 2.0,
                    color: colors[15],
                  ),
                  insets: EdgeInsets.symmetric(horizontal:20.0),

              ),
              tabs: widget.categories.map((Category category) {
                return Container(
                    padding: EdgeInsets.only(bottom: 7),
                    //margin: EdgeInsets.only(right: 8, top: 10),
                    //padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 110,
                        height: 30,
                        decoration: BoxDecoration(color: colors[9]),
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: Text(
                                    category.name.ru,
                                    style:
                                        TextStyle(color: borders[9], fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  category.items.toString(),
                                  style: TextStyle(color: borders[9], fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                      ),
                    ));
              }).toList()),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              FutureBuilder<List<Wallpaper>>(
                future: fetchWallpaper('https://wallpaper4k.ru/api/v1/wallpapers?size=20'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? WallpaperList(walls: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
              Center(
                child: Text(
                  'KALTEGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'HEIBGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'MILCHPPODUKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'BROTCHEN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'KALTEGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'HEIBGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'MILCHPPODUKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'BROTCHEN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'KALTEGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'HEIBGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'MILCHPPODUKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'BROTCHEN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'KALTEGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  'HEIBGETRANKE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
//        Expanded(
//          child: Container(
//              padding: EdgeInsets.all(5),
//              child: TabBarView(
//                controller: _tabController,
//                children: widget.categories.map(
//                  (Category category) {
//                    return Container(
//                        padding: EdgeInsets.only(bottom: 10),
//                        //margin: EdgeInsets.only(right: 8, top: 10),
//                        //padding: EdgeInsets.symmetric(horizontal: 10),
//                      child: Text(category.name.ru),
//                    );
//                  },
//                ).toList(),
//              )),
//        )
      ],
    );
//           return  Container(
//          height: 70,
//          child: ListView.builder(
//            padding: EdgeInsets.symmetric(horizontal: 7),
//            shrinkWrap: true,
//            scrollDirection: Axis.horizontal,
//            itemCount: widget.categories.length,
//            itemBuilder: (context, index) {
//              return Container(
//                  margin: EdgeInsets.only(right: 8, top: 10),
//                  //padding: EdgeInsets.symmetric(horizontal: 10),
//                  child: GestureDetector(
//                    onTap: () {
//                      print(widget.categories[index].name.ru);
////                      Navigator.of(context).push(
////                        MaterialPageRoute(
////                          builder: (context) => _futureWalls(walls, widget
////                              .categories[index].id),
////                        ),
////                      );
//                },
//                    child: Stack(
//                      children: [
//                        ClipRRect(
//                          borderRadius: BorderRadius.circular(5),
//                          child: Container(
//                            //padding: EdgeInsets.only(right: 4),
//                            width: 110,
//                            height: 30,
//                            child: SizedBox(
//                              width: double.infinity,
//                              child: Container(
//                                decoration: BoxDecoration(color: colors[index]),
//                                child: SizedBox(
//                                  child: Container(
//                                    width: 110,
//                                    height: 30,
//                                    alignment: Alignment.center,
//                                    padding: EdgeInsets.symmetric(horizontal: 5),
//                                    child: FittedBox(
//                                      fit: BoxFit.fill,
//                                      child: Text(
//                                        widget.categories[index].name.ru,
//                                        style: TextStyle(
//                                            color: borders[index], fontWeight: FontWeight.w400),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ));
//            },
//          ),
//        );
  }
}

Widget _grid(walls) {
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.fromLTRB(7, 0, 7, 20),
    itemCount: walls.length + 1,
    crossAxisCount: 4,
    itemBuilder: (context, index) {
      if (index >= walls.length) {
        return CupertinoActivityIndicator();
      } else {
        String imgPath = walls[index].image.url;
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

//Widget _futureWalls(category_id, walls) {
//  int page = 1;
//  int currentPage = page + 1;
//  return FutureBuilder<List<Wallpaper>>(
//    future: fetchWallpaper(page: currentPage, category_id: category_id),
//    builder: (context, snapshot) {
//      if (snapshot.hasError) print(snapshot.error);
//      return snapshot.hasData ? _grid(walls) : Center(child: CircularProgressIndicator());
//    },
//  );
//}
