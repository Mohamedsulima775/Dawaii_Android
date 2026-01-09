// lib/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../services/api_service.dart';
import '../models/product.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService api;

  ProductRepositoryImpl(this.api);

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

      //final List data = response['message'];
      final List data = (response['message'] as List?) ?? [];

      return Right(data.map((e) => Product.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
      //return Left(ServerFailure.fromException(e));

    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    try {
      final response = await api.get(
        '/api/method/my_medicinal.api.product.get_product',
        params: {'product_id': productId},
      );

      return Right(Product.fromJson(response['message']));
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

      //final List data = response['message'];
      final List data = (response['message'] as List?) ?? [];

      return Right(data.map((e) => Product.fromJson(e)).toList());
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


      // final List data = response['message'];
      final List data = (response['message'] as List?) ?? [];

      return Right(data.map((e) => Product.fromJson(e)).toList());
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

      return Right(response['message']['available'] ?? false);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}