import 'package:flutter/cupertino.dart';

class CategoryData {
  String name;
  String imgPath;
  Color color;

  CategoryData(this.name, this.imgPath, this.color);
}

enum Category { UMUM, CINTA, KELUARGA, TEMAN, PENDIDIKAN, PEKERJAAN }

extension CatExtension on Category {
  CategoryData get categoryData {
    switch (this) {
      case Category.UMUM:
        return CategoryData(
            "Umum", "assets/images/ic_umum.svg", Color(0xFF6280FF));
      case Category.CINTA:
        return CategoryData(
            "Cinta", "assets/images/ic_cinta.svg", Color(0xFFFA91A5));
      case Category.KELUARGA:
        return CategoryData(
            "Keluarga", "assets/images/ic_keluarga.svg", Color(0xFF82C168));
      case Category.TEMAN:
        return CategoryData(
            "Teman", "assets/images/ic_teman.svg", Color(0xFF11CBE0));
      case Category.PENDIDIKAN:
        return CategoryData("Pendidikan", "assets/images/ic_pendidikan.svg",
            Color(0xFF6BC8ABB));
      case Category.PEKERJAAN:
        return CategoryData(
            "Pekerjaan", "assets/images/ic_pekerjaan.svg", Color(0xFFFFB55E));
      default:
        return null;
    }
  }
}
