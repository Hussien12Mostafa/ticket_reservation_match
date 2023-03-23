class Team {
  final String id;
  String name;
  Team({this.id, this.name});
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      name: json['name'],
    );
  }
}
