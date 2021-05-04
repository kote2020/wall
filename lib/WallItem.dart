
import 'package:wallpaper/station.dart';

class WallItem {
  final String url;

  WallItem({this.url});

  factory WallItem.fromJson(Map<String, dynamic> json) {
    final data = WallItem(
      url: json['url']
    );
    return data;
  }
}