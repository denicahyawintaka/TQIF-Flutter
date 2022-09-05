class Diary {
  int id;
  String date;
  String category;
  String emoticon;
  String content;

  Diary(int id, String date, String category, String emoticon, String content) {
    this.id = id;
    this.date = date;
    this.category = category;
    this.emoticon = emoticon;
    this.content = content;
  }

  Diary.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map['date'],
        category = map['category'],
        emoticon = map['emoticon'],
        content = map['content'];

  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['date'] = date;
    map['category'] = category;
    map['emoticon'] = emoticon;
    map['content'] = content;
    return map;
  }
}
