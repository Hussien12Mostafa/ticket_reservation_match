class Stadium {
  final String id;
  String name;
  int rows;
  int columns;
  Stadium({this.id, this.name, this.columns, this.rows});
  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      id: json['_id'],
      name: json['name'],
      rows: json['rows'],
      columns: json['columns'],
    );
  }
}
