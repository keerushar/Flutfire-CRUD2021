class Note {
  final String? title;
  final String? desc;
  final String? id;

  Note({this.id, this.title, this.desc});

  Note.fromMap(Map<String, dynamic> data, String id)
      : title = data["title"],
        desc = data["desc"],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "desc": desc,
    };
  }
}
