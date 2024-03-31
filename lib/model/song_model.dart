class SongModel{
  String songName;
  String songUrl;
  String imageUrl;
  String artist;


  SongModel({
    required this.songName,
    required this.songUrl,
    required this.imageUrl,
    required this.artist,
  });


  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      songName: json["songName"],
      songUrl: json["songUrl"],
      imageUrl: json["imageUrl"],
      artist: json["artist"],
    );
  }
}


