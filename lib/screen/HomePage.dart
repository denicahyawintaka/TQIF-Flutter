import 'package:diary_app/DatabaseManager.dart';
import 'package:diary_app/models/Category.dart';
import 'package:diary_app/models/Diary.dart';
import 'package:diary_app/screen/DiaryViewPage.dart';
import 'package:diary_app/screen/SelectDiaryPage.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Diary> diaries;

  getAllDiary() async {
    Database database = await DatabaseManager.instance.database;
    List<Map<String, dynamic>> maps =
        await database.query('Diary', orderBy: "id DESC");
    if (maps.isNotEmpty) {
      setState(() {
        diaries = maps.map((map) => Diary.fromDbMap(map)).toList();
      });
    }
  }

  @override
  void initState() {
    getAllDiary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E1A33), body: content());
  }

  Widget content() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      coverView(),
      headerView(),
      diaries == null
          ? emptyView()
          : Expanded(
              child: ListView.builder(
                  itemCount: diaries.length,
                  padding: EdgeInsets.only(bottom: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return diaryCard(diaries[index]);
                  }),
            )
    ]);
  }

  Widget coverView() {
    return Image.asset(
      "assets/images/header_image.png",
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  Widget headerView() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hallo, Deni",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            children: [
              SvgPicture.asset("assets/images/ic_calendar.svg"),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectDiaryPage(),
                          )),
                    },
                    child: SvgPicture.asset("assets/images/ic_filter.svg")),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget diaryCard(Diary diary) {
    final categoryData =
        EnumToString.fromString(Category.values, diary.category).categoryData;
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DiaryViewPage(
                    id: diary.id,
                  )),
        )
      },
      child: Card(
        margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        color: categoryData.color,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
              minHeight: 150, minWidth: double.infinity, maxHeight: 150),
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Opacity(
                      opacity: 0.5,
                      child: SvgPicture.asset(categoryData.imgPath))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          diary.date,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/images/ic_happy.svg",
                          width: 45,
                          height: 40,
                        )
                      ],
                    ),
                    Text(
                      categoryData.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        diary.content,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emptyView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SvgPicture.asset("assets/images/empty_diary.svg"),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
          child: Text(
            "Diary kamu masih kosong nih, yuk mulai menulis untuk mengekspresikan perasaan mu",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
