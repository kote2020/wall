//List<Wall> wall;
//
//Future<List<Wall>> fetchImages(http.Client client) async {
//  print('fetch');
//  final response = await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));
//  return compute(parseImages, response.body);
//}

//List<Wall> parseImages(String responseBody) {
//  print('parse');
//  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//final get = parsed['list'];
//print(parsed['list']);
//  return parsed['list'].map<Wall>((json) => Wall.fromJson(json)).toList();
//}

//Future<List<Wall>> fetchImages(http.Client client) async {
//  print('fetch');
//  final response =
//      await client.get(Uri.parse('https://wallpaper4k.ru/api/v1/wallpapers'));
//  //List<Wall> images = imageObjsJson.map((tagJson) => Wall.fromJson(tagJson)).toList();
//
//  //List<dynamic> data = map["list"];
//  //final infoImage = json.decode(response.body);
//
//  //image = infoImage['image'];
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parseImages, response.body);
//}

//Future<List<Station>> fetchStations(http.Client client) async {
//  print('fetch');
//  final response = await client
//      .get(Uri.parse('https://radio.bobrilka.ru/api/radio-stations'));
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parseStation, response.body);
//}

//A function that converts a response body into a List<Photo>.
//List<Wall> parseImages(String responseBody) {
//  Map image;
//  print('parse');
//  //Wall wall = Wall.fromJson(jsonDecode(responseBody));
//  final parsed = jsonDecode(responseBody).cast<String, dynamic>() as List;
//  //final image = jsonDecode(responseBody)['list'] as List;
//  print(parsed);
//  //print(parsed['list']);
//  return parsed.map<Wall>((json) => Wall.fromJson(json)).toList();
//}

//List<Station> parseStation(String responseBody) {
//  print('parse');
//  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
//  //print(parsed['items']);
//  return parsed['items']
//      .map<Station>((json) => Station.fromJson(json))
//      .toList();
//}

//class MyHomePage extends StatelessWidget {
//  final List<Wall> images;
//
//  //final List<Wall> stations;
//
//  //MyHomePage({Key key, this.images}) : super(key: key);
//  MyHomePage({Key key, this.images}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(
//            'Wallpaper2You',
//            //'Radio',
//            style: TextStyle(
//              fontFamily: "Montserrat",
//              fontWeight: FontWeight.w300,
//            ),
//          ),
//          centerTitle: true,
//          backgroundColor: Colors.blueGrey,
//        ),
//        body: FutureBuilder<List<Wall>>(
//          future: fetchImages(http.Client()),
//          builder: (context, snapshot) {
//            if (snapshot.hasError) print(snapshot.error);
//            return snapshot.hasData
//                ? ImageList(images: snapshot.data)
//                : Center(child: Text('loading...'));
//          },
//        ),
//        backgroundColor: Colors.grey[100],
//      ),
//    );
//  }
//}
//
//void _save(url) async {
//void _save(url) async {
//  var response =
//      await Dio().get(url, options: Options(responseType: ResponseType.bytes));
//  var status = await Permission.photos.request();
//  var name = new File(url);
//  var name_right = basename(name.path);
//  if (Platform.isAndroid) {
//    if (await _requestPermission(Permission.storage)) {
//      if (status.isGranted) {
//        return await ImageGallerySaver.saveImage(
//            Uint8List.fromList(response.data),
//            quality: 60,
//            name: name_right.split(".").first);
//      }
//    }
//  }
//
//  //print(result);
//}
//
//Future<bool> _requestPermission(Permission permission) async {
//  if (await permission.isGranted) {
//    return true;
//  } else {
//    var result = await permission.request();
//    if (result == PermissionStatus.granted) {
//      return true;
//    }
//  }
//  return false;
//}
//
//
//class ImageList extends StatelessWidget {
//  final List<Wall> images;
//
//  ImageList({Key key, this.images}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//      ),
//      padding: EdgeInsets.all(5),
//      itemCount: images.length,
//      itemBuilder: (context, index) {
//        return Text(
//          "${images[index].id}"
//        );
//      },
//    );
//  }
//
////class StationList extends StatelessWidget {
////  final List<Station> stations;
////
////  StationList({Key key, this.stations}) : super(key: key);
////
////  @override
////  Widget build(BuildContext context) {
////    return GridView.builder(
////      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////        crossAxisCount: 2,
////      ),
////      padding: EdgeInsets.all(5),
////      itemCount: stations.length,
////      itemBuilder: (context, index) {
////        return InkWell(
////          onTap: () {
////            //_save("${stations[index].icon}");
////            _save("${stations[index].icon}");
////            print('save -> ' + " ${stations[index].icon}");
////          },
////          child: Container(
////            width: 200,
////            margin: EdgeInsets.all(6),
////            child: ClipRRect(
////              borderRadius: BorderRadius.circular(7),
////              child: FadeInImage.memoryNetwork(
////                placeholder: kTransparentImage,
////                image: "${stations[index].icon}",
////                //fadeInDuration: Duration.millisecondsPerDay,
////              ),
////            ),
////          ),
////        );
////      },
////    );
////  }
//}


//new StaggeredGridView.countBuilder(
//controller: _scrollController,
////reverse: true,
////shrinkWrap: true,
//padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//itemCount: images.length + 1,
//crossAxisCount: 4,
//itemBuilder: (context, index) {
//if (index == images.length) {
//return CupertinoActivityIndicator();
//}
//String imgPath = images[index]['image']['url'];
//return new Material(
//elevation: 3.0,
//borderRadius: new BorderRadius.circular(8.0),
//shadowColor: Colors.grey.shade50,
//child: new InkWell(
//onTap: () => Navigator.push(
//context,
//new MaterialPageRoute(
//builder: (context) => new FullScreen(
//imageUrl: images[index]['image']['fullPath']))),
//child: ClipRRect(
//borderRadius: BorderRadius.circular(8.0),
//child: new Hero(
//tag: 'tagImage$index',
//child: new FadeInImage(
////placeholder: 'assets/images/loading.gif',
//placeholder: new AssetImage('assets/images/load_sm.gif'),
//image: new NetworkImage(imgPath),
//fit: BoxFit.cover,
////fadeInDuration: Duration.millisecondsPerDay,
//),
//),
//),
//));
//},
//staggeredTileBuilder: (int index) =>
//new StaggeredTile.count(2, index.isEven ? 2 : 3),
//mainAxisSpacing: 10.0,
//crossAxisSpacing: 10.0
//,
//)
//






//
//body: Column(
//children: [
////          Container(
////            child: Text('hello'),
////          ),
////          Center(
////            child: CircularProgressIndicator(),
////          ),
//Expanded(
//child: Container(
//child: images != null
//? FutureBuilder(
//future: fetchImages(http.Client()),
//builder: (context, response) {
//if (response.hasError) print(response.error);
//return response.hasData
//? new StaggeredGridView.countBuilder(
//controller: _scrollController,
////reverse: true,
////shrinkWrap: true,
//padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//physics: BouncingScrollPhysics(
//parent: AlwaysScrollableScrollPhysics()),
//itemCount: _images.length + 1,
//crossAxisCount: 4,
//itemBuilder: (context, index) {
//if (index == _images.length) {
//return CupertinoActivityIndicator();
//}
//String imgPath = _images[index].caption;
//return Text(imgPath);
////                                      return new Material(
////                                          elevation: 3.0,
////                                          borderRadius: new BorderRadius.circular(8.0),
////                                          shadowColor: Colors.grey.shade50,
////                                          child: new InkWell(
////                                            onTap: () => Navigator.push(
////                                                context,
////                                                new MaterialPageRoute(
////                                                    builder: (context) => new FullScreen(
////                                                        imageUrl: images[index]['list']['id']))),
////                                            child: ClipRRect(
////                                              borderRadius: BorderRadius.circular(8.0),
////                                              child: new Hero(
////                                                tag: 'tagImage$index',
////                                                child: new FadeInImage(
////                                                  //placeholder: 'assets/images/loading.gif',
////                                                  placeholder:
////                                                      new AssetImage('assets/images/load_sm.gif'),
////                                                  image: new NetworkImage(imgPath),
////                                                  fit: BoxFit.cover,
////                                                  //fadeInDuration: Duration.millisecondsPerDay,
////                                                ),
////                                              ),
////                                            ),
////                                          ));
//},
//staggeredTileBuilder: (int index) =>
//new StaggeredTile.count(2, index.isEven ? 2 : 3),
//mainAxisSpacing: 10.0,
//crossAxisSpacing: 10.0,
//)
//    : new Center(
//child: Text('loading...'),
////child: new CircularProgressIndicator(),
//);
//},
//)
//: new Center(
//child: Text('loading'),
//))),
//InkWell(
//onTap: () {
////              _loadMore();
//},
//child: Container(
//height: 60,
//width: double.infinity,
//color: Color.fromRGBO(0, 0, 0, 1),
//child: Center(
//child: Text(
//'Загрузить еще',
//style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
//),
//),
//),
//)
//],
//),
