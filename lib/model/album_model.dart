import 'package:nepalihiphub/model/song_model.dart';

class AlbumModel {
  String id;
  List<SongModel> song;
  String albumName;
  String imageUrl;
  String artist;

  AlbumModel({
    required this.id,
    required this.song,
    required this.albumName,
    required this.imageUrl,
    required this.artist,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json["_id"],
      song: List<SongModel>.from(json["song"].map((x) => SongModel.fromJson(x))),
      albumName: json["albumName"],
      imageUrl: json["imageUrl"],
      artist: json["artist"],
    );
  }
}
