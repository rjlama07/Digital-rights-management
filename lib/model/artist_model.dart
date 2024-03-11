class ArtistModel {
  String id;
  String name;
  String email;
  String profileUrl;
  String activeSince;
  bool isFollowing;

  ArtistModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.profileUrl,
      required this.activeSince,
      required this.isFollowing});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        profileUrl: json['profileUrl'],
        activeSince: json['activeSince'],
        isFollowing: json['isFollowing'] ?? false);
  }
  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'profileUrl': profileUrl,
        'activeSince': activeSince
      };

  ArtistModel copyWith(
      {String? id,
      String? name,
      String? email,
      String? profileUrl,
      String? activeSince,
      bool? isFollowing}) {
    return ArtistModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profileUrl: profileUrl ?? this.profileUrl,
        activeSince: activeSince ?? this.activeSince,
        isFollowing: isFollowing ?? this.isFollowing);
  }
}
