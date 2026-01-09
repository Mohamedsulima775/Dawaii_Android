// lib/data/repositories/product_repository.dart

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../models/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, Product>> getProductById(String productId);

  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);

  Future<Either<Failure, List<Product>>> getFeaturedProducts();

  Future<Either<Failure, bool>> checkStock({
    required String productId,
    required int quantity,
  });
}