class BeatModel {
  String? beatName;
  String? beatUrl;
  String? producerName;

  BeatModel(
      {required this.beatName,
      required this.beatUrl,
      required this.producerName});

  BeatModel.fromJson(Map<String, dynamic> json) {
    beatName = json["beatName"];
    beatUrl = json["beatUrl"];
    producerName = json["producerName"];
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
