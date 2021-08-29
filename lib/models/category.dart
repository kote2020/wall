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
        'name': name,
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


//        Container(
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
//                      Navigator.of(context).push(
//                        MaterialPageRoute(
//                          builder: (context) => _futureWalls(walls, widget
//                              .categories[index].id),
//                        ),
//                      );
//                    },
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
//        ),