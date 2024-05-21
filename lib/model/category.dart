class CategoryModel {
  final String? id;
  final String name;
  final String iconId;
  final bool? isFavorite;
  CategoryModel(
      {required this.name, required this.iconId, this.isFavorite, this.id});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      iconId: map['iconId'],
      isFavorite: map['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'iconId': iconId, 'isFavorite': isFavorite};
  }
}
