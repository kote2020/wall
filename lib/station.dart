class Station {
  final int id_ex;
  final String name;
  final String icon;
  final String stream;

  Station({this.id_ex, this.name, this.icon, this.stream});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
        id_ex : json['id'],
        name : json['name'] as String,
        stream : json['stream'] as String,
        icon : json['icon'] as String,
    );
  }

}