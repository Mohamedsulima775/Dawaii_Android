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

  // Helper method to safely extract list from response
  List _extractList(dynamic data) {
    if (data == null) return [];
    if (data is List) return data;
    if (data is String) return []; // API returned string instead of list
    if (data is Map && data.containsKey('data')) {
      return _extractList(data['data']);
    }
    return [];
  }

  @override
  Future<Either<Failure, List<CategoryItem>>> getCategories() async {
    try {
      final response = await apiService.get('/categories');

      final List data = _extractList(response['data']);
      final categories = data
          .map((json) => CategoryItem.fromJson(json as Map<String, dynamic>))
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
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final category = CategoryItem.fromJson(data);
        return Right(category);
      }
      return Left(ServerFailure('Invalid response format'));
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

      final List data = _extractList(response['data']);
      final subcategories = data
          .map((json) => CategoryItem.fromJson(json as Map<String, dynamic>))
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
