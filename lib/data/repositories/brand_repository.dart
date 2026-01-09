

// ============================================
// lib/data/repositories/brand_repository.dart
// ============================================

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../models/brand.dart';

abstract class BrandRepository {
  Future<Either<Failure, List<Brand>>> getBrands();
  Future<Either<Failure, Brand>> getBrandById(String brandId);
  Future<Either<Failure, List<Brand>>> getPopularBrands();
  Future<Either<Failure, List<Brand>>> getFeaturedBrands();
  Future<List<Brand>> getCachedBrands();
}

