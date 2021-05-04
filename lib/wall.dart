import 'package:flutter/cupertino.dart';
import 'package:wallpaper/WallItem.dart';

//
//class Image {
//  final String url;
//
//  Image({this.url});
//
//  factory Image.fromJson(Map<String, dynamic> json) {
//    return Image(
//      url: json['url'] as String,
//    );
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['url'] = this.url;
//    return data;
//  }
//}
//
//class Wall {
//  final int id;
//  final String caption;
//
//  //Image image;
//  //final List<Image> image;
//  final Image image;
//
//  Wall({this.id, this.caption, this.image});
//
//  factory Wall.fromJson(Map<String, dynamic> json) => Wall(
//    caption: json["caption"] == null ? null : json["caption"],
//    id: json["id"] == null ? null : json["id"],
//    image: json["image"] == null ? null : Image.fromJson(json["image"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "caption": caption == null ? null : caption,
//    "id": id == null ? null : id,
//    "image": image == null ? null : image.toJson(),
//  };

class Wall {
  int id;
  String caption;
  List<WallItem> image;

  Wall({this.id, this.caption, this.image});

  factory Wall.fromJson(Map<String, dynamic> json) {
    var id  = json['id'];
    var caption = json['caption'];
    var images = json['image'] as List;
    List<WallItem> listImages = images.map((json) => WallItem.fromJson(json)).toList();

    final data = Wall(
      id : id,
      caption: caption,
      image : listImages
    );
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caption'] = this.caption;
    return data;
  }

//  factory Wall.fromJson(Map<String, dynamic> json) {
//    return Wall(id: json['id'], caption: json['caption'] as String);
//  }
}
