class BirdLibrary {
  final List<Bird> birds;

  BirdLibrary({this.birds});

  factory BirdLibrary.fromJson(Map<String, dynamic> jsonData) {
    var dynamicList = jsonData['Birds'] as List;
    List<Bird> birdList = dynamicList.map((i) => Bird.fromJson(i)).toList();
    return BirdLibrary(birds: birdList);
  }
}

class Bird {
  final int id;
  final String code;
  final String orderLatin;
  final String orderFin;
  final String tribeLatin;
  final String tribeFin;
  final String nameLatin;
  final String nameFin;
  final String nameSve;
  final String nameEng;
  final String isCommon;

  Bird(
      {this.id,
      this.code,
      this.orderLatin,
      this.orderFin,
      this.tribeLatin,
      this.tribeFin,
      this.nameLatin,
      this.nameFin,
      this.nameSve,
      this.nameEng,
      this.isCommon});

  factory Bird.fromJson(Map<String, dynamic> jsonObject) {
    return Bird(
        id: int.parse(jsonObject["Id"]),
        code: jsonObject["Code"],
        orderLatin: jsonObject["OrderLatin"],
        orderFin: jsonObject["OrderFin"],
        tribeLatin: jsonObject["TribeLatin"],
        tribeFin: jsonObject["TribeFin"],
        nameLatin: jsonObject["NameLatin"],
        nameFin: jsonObject["NameFin"],
        nameSve: jsonObject["NameSve"],
        nameEng: jsonObject["NameEng"],
        isCommon: jsonObject["IsCommon"]);
  }
}
