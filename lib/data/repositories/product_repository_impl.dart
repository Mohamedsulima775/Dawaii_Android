// lib/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../services/api_service.dart';
import '../models/product.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService api;

  ProductRepositoryImpl(this.api);

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
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.get_products',
        params: {
          'page': page.toString(),
          'limit': limit.toString(),
        },
      );

      final List data = _extractList(response['message']);

      return Right(data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.get_product',
        params: {'product_id': productId},
      );

      final data = response['message'];
      if (data is Map<String, dynamic>) {
        return Right(Product.fromJson(data));
      }
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String categoryId) async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.get_products_by_category',
        params: {'category': categoryId},
      );

      final List data = _extractList(response['message']);

      return Right(data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts() async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.get_featured_products',
      );

      final List data = _extractList(response['message']);

      return Right(data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkStock({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.check_stock',
        params: {
          'product_id': productId,
          'quantity': quantity.toString(),
        },
      );

      final message = response['message'];
      if (message is Map<String, dynamic>) {
        return Right(message['available'] ?? false);
      }
      return const Right(false);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
