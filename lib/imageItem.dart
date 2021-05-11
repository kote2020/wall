import 'package:flutter/material.dart';
import 'package:wallpaper/full_screen.dart';
import 'package:wallpaper/wall.dart';
import 'package:flutter/services.dart';

class ImageItem extends StatefulWidget {
  const ImageItem({Key key, this.wall}) : super(key: key);

  final Wall wall;

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    String imgPath = widget.wall.image.url;
    return new Material(
        elevation: 3.0,
        borderRadius: new BorderRadius.circular(8.0),
        shadowColor: Colors.grey.shade50,
        child: new InkWell(
          onTap: () => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new FullScreen(imageUrl: imgPath))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: new Hero(
              tag: 'tagImage',
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
  }
}
