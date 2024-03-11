class BeatModel {
  String? id;
  String? beatName;
  String? beatUrl;
  String? producerName;
  String? imageUrl;
  bool? isFav;

  BeatModel({
    required this.beatName,
    required this.beatUrl,
    required this.id,
    required this.imageUrl,
    required this.isFav,
    required this.producerName,
  });

  BeatModel.fromJson(Map<String, dynamic> json) {
    beatName = json["beatName"];
    beatUrl = json["beatUrl"] ?? "";
    producerName = json["producerName"];
    imageUrl = json["imageUrl"] ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQub8LN4xkfJZkGxHy0wWdrrdwSqBkbYy9Jew&usqp=CAU";
    isFav = json["isFav"] ?? false;
    id = json["_id"];
  }
}

class PaidBeatModel {
  String? beatName;
  String? producerName;
  String? price;
  String? sampleUrl;

  PaidBeatModel(
      {required this.sampleUrl,
      required this.beatName,
      required this.price,
      required this.producerName});

  PaidBeatModel.fromJson(Map<String, dynamic> json) {
    beatName = json["beatName"];
    producerName = json["producerName"];
    price = json["price"];
    sampleUrl = json["sampleUrl"];
  }
}
