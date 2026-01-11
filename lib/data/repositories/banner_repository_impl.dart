// ============================================
// lib/data/repositories/banner_repository_impl.dart
// ============================================

import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../services/api_service.dart';
import '../models/banner_model.dart';
import 'banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final ApiService apiService;

  BannerRepositoryImpl({
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
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    try {
      final response = await apiService.get('/banners');
      final List data = _extractList(response['data']);
      final banners = data
          .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BannerModel>>> getBannersByLocation(
      String location,
      ) async {
    try {
      final response = await apiService.get(
        '/banners',
        params: {'location': location},
      );

      final List data = _extractList(response['data']);
      final banners = data
          .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BannerModel>> getBannerById(String bannerId) async {
    try {
      final response = await apiService.get('/banners/$bannerId');
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final banner = BannerModel.fromJson(data);
        return Right(banner);
      }
      return Left(ServerFailure('Invalid response format'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> trackBannerClick(String bannerId) async {
    try {
      await apiService.post('/banners/$bannerId/click');
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> trackBannerImpression(
      String bannerId,
      ) async {
    try {
      await apiService.post('/banners/$bannerId/impression');
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  getCachedBanners() {
    // TODO: implement getCachedBanners
    throw UnimplementedError();
  }
}
