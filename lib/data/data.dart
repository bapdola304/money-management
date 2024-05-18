import 'package:flutter/material.dart';

class CategoryModel {
  final String icon;
  final String? name;

  const CategoryModel({
    required this.icon,
    this.name,
  });
}

const List<Color> listColor = <Color>[
  Color(0xFFF56287),
  Color(0xFF37B34A),
  Color(0xFF1488CC),
  Color(0xFFE0B719),
  Color(0xffB455FF),
  Color(0xff07BBC7),
  Color(0xffFF5A5A),
];

List<CategoryModel> listProjects = <CategoryModel>[
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 1"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 2"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 3"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 4"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 3"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 4"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 3"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 4"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 3"),
  CategoryModel(icon: 'assets/icons/wallet.png', name: "Mohammed Benmchich 4")
];
