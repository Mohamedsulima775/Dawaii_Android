// ============================================
// lib/data/repositories/category_repository_impl.dart
// ============================================

import 'package:dartz/dartz.dart';


import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../services/api_service.dart';
import '../models/category_item.dart';
import 'category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiService apiService;

  CategoryRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<CategoryItem>>> getCategories() async {
    try {
      final response = await apiService.get('/categories');

      final categories = (response['data'] as List)
          .map((json) => CategoryItem.fromJson(json))
          .toList();

      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryItem>> getCategoryById(
      String categoryId,
      ) async {
    try {
      final response = await apiService.get('/categories/$categoryId');
      final category = CategoryItem.fromJson(response['data'] );

      return Right(category);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryItem>>> getSubcategories(
      String parentId,
      ) async {
    try {
      final response = await apiService.get(
        '/categories',
        params: {'parent_id': parentId},
      );

      final subcategories = (response['data'] as List)
          .map((json) => CategoryItem.fromJson(json))
          .toList();

      return Right(subcategories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<List<CategoryItem>> getCachedCategories() {
    // TODO: implement getCachedCategories
    throw UnimplementedError();
  }
}