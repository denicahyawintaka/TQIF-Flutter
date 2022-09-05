import 'package:diary_app/DatabaseManager.dart';
import 'package:diary_app/models/Category.dart';
import 'package:diary_app/models/Diary.dart';
import 'package:diary_app/models/Emoticon.dart';
import 'package:diary_app/screen/DiaryPage.dart';
import 'package:diary_app/screen/HomePage.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite/sqflite.dart';

class DiaryViewPage extends StatefulWidget {
  const DiaryViewPage({Key key, this.id}) : super(key: key);

  final id;

  @override
  _DiaryViewPageState createState() => _DiaryViewPageState(id);
}

class _DiaryViewPageState extends State<DiaryViewPage> {
  _DiaryViewPageState(this.id);

  Diary diary;
  int id;

  getDiaryById(int id) async {
    Database database = await DatabaseManager.instance.database;
    List<Map<String, dynamic>> maps =
        await database.query('Diary', where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      setState(() {
        diary = Diary.fromDbMap(maps.first);
      });
    }
  }

  deleteDiaryById(int id) async {
    Database database = await DatabaseManager.instance.database;
    int result =
        await database.delete('Diary', where: "id = ?", whereArgs: [id]);
    if (result != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    }
  }

  @override
  void initState() {
    getDiaryById(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1A33),
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: GestureDetector(
                onTap: () => {deleteDiaryById(id)}, child: Text("Hapus")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: GestureDetector(
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiaryPage(diary: diary),
                          )),
                    },
                child: Text("Sunting")),
          )
        ],
      ),
      body: diary != null
          ? diaryField()
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget diaryHeader(CategoryData categoryData) {
    final emoticonData =
        EnumToString.fromString(Emoticon.values, diary.emoticon).emoticonData;
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(diary.date,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(categoryData.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ),
            SvgPicture.asset(emoticonData.imgPath)
          ]),
    );
  }

  Widget diaryField() {
    final categoryData =
        EnumToString.fromString(Category.values, diary.category).categoryData;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: categoryData.color,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                diaryHeader(categoryData),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    diary.content,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Opacity(
                  opacity: 0.4,
                  child: SvgPicture.asset(categoryData.imgPath,
                      width: 150, height: 150)),
            ),
          ],
        ),
      ),
    );
  }
}
