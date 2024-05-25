import 'package:nepalihiphub/model/song_model.dart';

class AlbumModel {
  String? id;
  String albumName;
  String imageUrl;
  String? artist;
  String type;
  List<SongModel> songs;
  String? price;
  bool? isBought;

  AlbumModel(
      {this.id,
      required this.albumName,
      required this.imageUrl,
      this.artist,
      required this.songs,
      this.price,
      required this.type,
      this.isBought});

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json["_id"],
      albumName: json["albumName"],
      imageUrl: json["imageUrl"],
      artist: json["artist"],
      songs: (json["songs"] as List).map((e) => SongModel.fromJson(e)).toList(),
      price: json["price"],
      type: json["type"],
      isBought: json["isBought"],
    );
  }
  //to convert the object to json
  Map<String, dynamic> toJson() {
    return {
      "albumName": albumName,
      "imageUrl": imageUrl,
      "artist": artist,
      "songs": songs.map((e) => e.toJson()).toList(),
      "price": type == "paid" ? price : null,
      "type": type,
    };
  }
}


  // _id: mongoose.Schema.Types.ObjectId,
  // albumName: String,
  // imageUrl: String,
  // artist: String,
  // songs: [songSchema], // List of song references