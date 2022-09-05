enum Emoticon { HAPPY, SAD, ANGRY, AFRAID, SURPRISE }

class EmoticonData {
  String name;
  String imgPath;

  EmoticonData(String name, String imgPath) {
    this.name = name;
    this.imgPath = imgPath;
  }
}

extension CatExtension on Emoticon {
  EmoticonData get emoticonData {
    switch (this) {
      case Emoticon.HAPPY:
        return EmoticonData("Senang", 'assets/images/ic_happy.svg');
      case Emoticon.SAD:
        return EmoticonData("Sedih", 'assets/images/ic_sad.svg');
      case Emoticon.ANGRY:
        return EmoticonData("Marah", 'assets/images/ic_angry.svg');
      case Emoticon.AFRAID:
        return EmoticonData("Takut", 'assets/images/ic_afraid.svg');
      case Emoticon.SURPRISE:
        return EmoticonData("Kaget", 'assets/images/ic_surprise.svg');
      default:
        return null;
    }
  }
}
