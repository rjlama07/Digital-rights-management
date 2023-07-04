class StudioModel {
  String? id;
  String? name;
  String? description;
  String? ratings;
  String? imageUrl;
  String? price;
  String? location;

  StudioModel(
      {this.id,
      this.description,
      this.ratings,
      this.imageUrl,
      this.price,
      this.location});

  StudioModel.formJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    ratings = json['rating'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    location = json['location'];
  }
}
