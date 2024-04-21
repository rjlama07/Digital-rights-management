class SongModel {
  String id;
  String songName;
  String songUrl;
  String imageUrl;
  String artist;
  int stream;

  SongModel(
      {required this.id,
      required this.songName,
      required this.songUrl,
      required this.imageUrl,
      required this.artist,
      required this.stream});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json["_id"],
      songName: json["songName"],
      songUrl: json["songUrl"],
      imageUrl: json["imageUrl"],
      artist: json["artistId"],
      stream: json["stream"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "songName": songName,
      "songUrl": songUrl,
      "imageUrl": imageUrl,
      "artist": artist,
      "stream": stream,
    };
  }
}
