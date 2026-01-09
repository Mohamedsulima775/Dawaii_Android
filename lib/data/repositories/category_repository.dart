
// ============================================
// lib/data/repositories/category_repository.dart
// ============================================

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/category_item.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryItem>>> getCategories();
  Future<Either<Failure, CategoryItem>> getCategoryById(String categoryId);
  Future<Either<Failure, List<CategoryItem>>> getSubcategories(String parentId);
  Future<List<CategoryItem>> getCachedCategories();

}

