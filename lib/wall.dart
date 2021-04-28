import 'package:flutter/cupertino.dart';

class Image {
  final String url;

  Image({this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Wall {
  final int id;
  final String caption;

  //Image image;
  //final List<Image> image;
  final Image image;

  Wall({this.id, this.caption, this.image});

  factory Wall.fromJson(Map<String, dynamic> json) => Wall(
    caption: json["caption"] == null ? null : json["caption"],
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "caption": caption == null ? null : caption,
    "id": id == null ? null : id,
    "image": image == null ? null : image.toJson(),
  };

//  factory Wall.fromJson(Map<String, dynamic> json){
//    List<Image> image = (json['image'] as List)
//        .map((imageJson) => Image.fromJson(imageJson))
//        .toList();
//    return Wall(
//      id: json['id'] as int,
//      caption: json['caption'].cast<String>(),
//      image: image,
//    );
    //image: Image.fromJson(json['image']));
  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['caption'] = this.caption;
//    data['image'] = this.image;
//    return data;
//  }
