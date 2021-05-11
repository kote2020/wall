import 'package:wallpaper/models/category.dart';

class Wallpaper {
  final int id;
  final String name;
  final String icon;
  final String caption;
  Category category;

  //Image image;

  Wallpaper({this.id, this.caption, this.name, this.icon, this.category});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json["id"],
      caption: json["caption"],
      name: json["name"],
      icon: json["icon"],
      category: Category.fromJson(json['category']),
      //image: Image.fromJson(json['image']),
      //name: List<Name>.from(json["name"].map((x) => Name.fromJson(x))),
    );
  }
}

class Image {
  String url;

  Image({this.url});

  factory Image.fromJson(Map<String, dynamic> json) => Image(url: json['url']);
}
