import 'package:diary_app/models/Category.dart';
import 'package:diary_app/models/Emoticon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'DiaryPage.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({Key key, this.emoticon}) : super(key: key);

  final emoticon;

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState(emoticon);
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  _SelectCategoryPageState(this.emoticon);

  Emoticon emoticon;

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
          crossAxisCount: 2,
          childAspectRatio: 1.7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            categoryCard(Category.UMUM, emoticon),
            categoryCard(Category.CINTA, emoticon),
            categoryCard(Category.KELUARGA, emoticon),
            categoryCard(Category.TEMAN, emoticon),
            categoryCard(Category.PENDIDIKAN, emoticon),
            categoryCard(Category.PEKERJAAN, emoticon)
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
        "Tentang apa yang ingin kamu tulis ?",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget categoryCard(Category category, Emoticon emoticon) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DiaryPage(
                    category: category,
                    emoticon: emoticon,
                  )),
        )
      },
      child: Card(
        color: category.categoryData.color,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      category.categoryData.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(category.categoryData.imgPath),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
