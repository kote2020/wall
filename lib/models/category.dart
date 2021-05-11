class Category {
  final int id;
  final int items;
  Name name;

  Category({this.id, this.items, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      items: json["items"],
      name: Name.fromJson(json['name']),
      //name: List<Name>.from(json["name"].map((x) => Name.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items,
      };
}

class Name {
  String ru;
  String en;

  Name({this.ru, this.en});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        ru: json["ru"],
        en: json["en"],
      );
}