import 'package:wallpaper/models/category.dart';

class Wallpaper {
  final int id;
  final int downloads;
  Image image;
  CategoryById category;

  Wallpaper({this.id, this.downloads, this.image, this.category});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
        id: json["id"],
        downloads: json["downloads"],
        image: Image.fromJson(json['image']),
        category: CategoryById.fromJson(json['category'])
        //name: List<Name>.from(json["name"].map((x) => Name.fromJson(x))),
        );
  }
}

class Image {
  String fullPath;
  String url;
  String preview;

  Image({this.fullPath, this.url, this.preview});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        fullPath: json["fullPath"],
        url: json["url"],
        preview: json["preview"],
      );
}

class CategoryById {
  int id;
  String ru;
  String en;

  CategoryById({this.id, this.ru, this.en});

  factory CategoryById.fromJson(Map<String, dynamic> json) => CategoryById(
        id: json["id"],
        ru: json["ru"],
        en: json["en"],
      );
}
