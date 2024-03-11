import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/model/song_model.dart';

class SearchModel {
  List<ArtistModel> artist;
  List<SongModel> song;

  SearchModel({
    required this.artist,
    required this.song,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      artist:
          (json["artist"] as List).map((e) => ArtistModel.fromJson(e)).toList(),
      song: (json["song"] as List).map((e) => SongModel.fromJson(e)).toList(),
    );
  }
}
