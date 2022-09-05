import 'package:diary_app/models/Emoticon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'SelectCategoryPage.dart';

class SelectMoodPage extends StatefulWidget {
  const SelectMoodPage({Key key}) : super(key: key);

  @override
  _SelectMoodPageState createState() => _SelectMoodPageState();
}

class _SelectMoodPageState extends State<SelectMoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1A33),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        coverView(),
        headerView(),
        //emptyView(),
        gridCategories()
      ]),
    );
  }

  Widget gridCategories() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            moodCard(Emoticon.SAD),
            moodCard(Emoticon.ANGRY),
            moodCard(Emoticon.AFRAID),
            moodCard(Emoticon.SURPRISE),
            moodCard(Emoticon.HAPPY),
          ],
        ),
      ),
    );
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
      child: Text(
        "Gimana perasaan kamu saat ini ?",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget moodCard(Emoticon emoticon) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectCategoryPage(
                    emoticon: emoticon,
                  )),
        )
      },
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF4C485C)),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(emoticon.emoticonData.imgPath)),
          Text(emoticon.emoticonData.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
