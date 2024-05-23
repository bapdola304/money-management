class IconModel {
  final String? id;
  final String image;
  IconModel({required this.image, this.id});

  factory IconModel.fromMap(Map<String, dynamic> map) {
    return IconModel(
      id: map['id'],
      image: map['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': id, 'image': image};
  }
}
