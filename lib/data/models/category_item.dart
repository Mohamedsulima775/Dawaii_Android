
import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String name;
  final String? nameAr;
  final IconData icon;
  final Color color;
  final Color iconColor;
  //final String? description;


  CategoryItem({
    required this.id,
    required this.name,
    this.nameAr,
    required this.icon,
    required this.color,
    this.iconColor=Colors.white,
   // this.description,


  });

}