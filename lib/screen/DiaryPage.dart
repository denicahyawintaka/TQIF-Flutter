import 'package:diary_app/DatabaseManager.dart';
import 'package:diary_app/models/Category.dart';
import 'package:diary_app/models/Diary.dart';
import 'package:diary_app/models/Emoticon.dart';
import 'package:diary_app/screen/HomePage.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key key, this.diary, this.category, this.emoticon})
      : super(key: key);

  final category;
  final emoticon;
  final diary;

  @override
  _DiaryPageState createState() => _DiaryPageState(category, emoticon, diary);
}

class _DiaryPageState extends State<DiaryPage> {
  final diaryController = TextEditingController();

  _DiaryPageState(this.category, this.emoticon, this.diary);

  Emoticon emoticon;
  Category category;
  Diary diary;

  Future<int> addDiary(Diary diary) async {
    Database database = await DatabaseManager.instance.database;
    var result = database.insert(
      'Diary',
      diary.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    }
  }

  updateDiaryById(int id, Diary diary) async {
    Database database = await DatabaseManager.instance.database;
    int result = await database
        .update('Diary', diary.toDbMap(), where: "id = ?", whereArgs: [id]);
    if (result != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (diary != null) {
      emoticon = EnumToString.fromString(Emoticon.values, diary.emoticon);
      category = EnumToString.fromString(Category.values, diary.category);
      diaryController.text = diary.content;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1E1A33),
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: Text("Batalkan"),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              diaryField(),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () => {
                    if (diary != null)
                      {
                        updateDiaryById(
                          diary.id,
                          Diary(
                              0,
                              currentDate(),
                              EnumToString.convertToString(category),
                              EnumToString.convertToString(emoticon),
                              diaryController.text),
                        )
                      }
                    else
                      {
                        addDiary(
                          Diary(
                              0,
                              currentDate(),
                              EnumToString.convertToString(category),
                              EnumToString.convertToString(emoticon),
                              diaryController.text),
                        )
                      }
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Widget diaryHeader() {
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
                  Text(currentDate(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(category.categoryData.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ),
            SvgPicture.asset(emoticon.emoticonData.imgPath)
          ]),
    );
  }

  Widget diaryField() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: category.categoryData.color,
        child: Container(
          constraints: BoxConstraints(
              minHeight: 100, minWidth: double.infinity, maxHeight: 400),
          child: Column(
            children: [
              diaryHeader(),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: SizedBox(
                        height: double.infinity,
                        child: TextField(
                          controller: diaryController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              hintText:
                                  'Tulis apa yang kamu pikirkan saat ini'),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                                category.categoryData.imgPath,
                                width: 150,
                                height: 150))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
