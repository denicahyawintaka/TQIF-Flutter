import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'SelectMoodPage.dart';

class SelectDiaryPage extends StatefulWidget {
  const SelectDiaryPage({Key key}) : super(key: key);

  @override
  _SelectDiaryPageState createState() => _SelectDiaryPageState();
}

class _SelectDiaryPageState extends State<SelectDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1A33),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 260.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(
                      "assets/images/header_image.png",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            headerView(),
            //emptyView(),
            diaryCard(
                "Diary Pintar",
                "Cocok banget buat kamu yang belum tahu mau nulis apa",
                "assets/images/smart_diary.svg",
                Color(0xFF6280FF)),
            diaryCard(
                "Diary Biasa",
                "Pas banget buat kamu yang sudah tau mau nulis apa",
                "assets/images/basic_diary.svg",
                Color(0xFFBC8ABB))
          ])),
    );
  }

  Widget headerView() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Text(
        "Pilih Diary yang kamu inginkan",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget diaryCard(
      String title, String message, String imgPath, Color backgroundColor) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectMoodPage()),
        )
      },
      child: Card(
        margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(imgPath)
            ],
          ),
        ),
      ),
    );
  }
}
