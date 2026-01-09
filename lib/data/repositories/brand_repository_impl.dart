// ============================================
// lib/data/repositories/brand_repository_impl.dart
// ============================================

import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../services/api_service.dart';
import '../../data/models/banner_model.dart';
import '../models/brand.dart';
import 'brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final ApiService apiService;

  BrandRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<Brand>>> getBrands() async {
    try {
      final response = await apiService.get(
        '/api/method/my_medicinal.api.brand.get_brands',
      );

      final List data = response['data']['message'];
      final brands = data.map((e) => Brand.fromJson(e)).toList();

      return Right(brands);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Brand>> getBrandById(String brandId) async {
    try {
      final response = await apiService.get(
        '/api/method/my_medicinal.api.brand.get_brand',
        params: {'brand_id': brandId},
      );

      final brand = Brand.fromJson(response['data']['message']);
      return Right(brand);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Brand>>> getPopularBrands() async {
    try {
      final response = await apiService.get(
        '/api/method/my_medicinal.api.brand.get_popular_brands',
      );

      final List data = response['data']['message'];
      final brands = data.map((e) => Brand.fromJson(e)).toList();

      return Right(brands);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Brand>>> getFeaturedBrands() async {
    try {
      final response = await apiService.get(
        '/api/method/my_medicinal.api.brand.get_featured_brands',
      );

      final List data = response['data']['message'];
      final brands = data.map((e) => Brand.fromJson(e)).toList();

      return Right(brands);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  /// ❌ لم يعد هناك Cache
  /// ❌ لذلك هذه الدالة أصبحت غير منطقية
  @override
  Future<List<Brand>> getCachedBrands() async {
    return [];
  }
}