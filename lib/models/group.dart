class Group {
  final String id;
  final String name;
  final List<String> usersId;

  Group({this.id, this.name, this.usersId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'usersId': usersId,
    };
  }
}
