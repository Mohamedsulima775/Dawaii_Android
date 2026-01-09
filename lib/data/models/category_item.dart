/*
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

 */

import 'package:flutter/material.dart';

class CategoryItem {
  // ===== API / DATA =====
  final String id;
  final String name;
  final String? nameAr;
  final String? description;
  final String? parentCategory;

  // ===== UI ONLY =====
  final IconData icon;
  final Color color;
  final Color iconColor;

  CategoryItem({
    required this.id,
    required this.name,
    this.nameAr,
    this.description,
    this.parentCategory,
    required this.icon,
    required this.color,
    this.iconColor = Colors.white,
  });

  // ===== From API =====
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      nameAr: json['name_ar'],
      description: json['description'],
      parentCategory: json['parent_category'], icon:Icons.beach_access, color: Colors.grey.shade500,
      // icon & colors لا تأتي من API
    );
  }

  // ===== To API (اختياري) =====
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'description': description,
      'parent_category': parentCategory,
    };
  }

  // ===== Helper للـ UI =====
  CategoryItem copyWith({
    IconData? icon,
    Color? color,
    Color? iconColor,
  }) {
    return CategoryItem(
      id: id,
      name: name,
      nameAr: nameAr,
      description: description,
      parentCategory: parentCategory,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}