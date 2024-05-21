class IconModel {
  final String id;
  final String image;
  IconModel({required this.image, required this.id});

  factory IconModel.fromMap(Map<String, dynamic> map) {
    return IconModel(
      id: map['id'],
      image: map['image'],
    );
  }
}
