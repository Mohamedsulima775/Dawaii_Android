
// ============================================
// lib/data/repositories/banner_repository.dart
// ============================================

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/banner_model.dart';


abstract class BannerRepository {
  Future<Either<Failure, List<BannerModel>>> getBanners();
  Future<Either<Failure, List<BannerModel>>> getBannersByLocation(String location);
  Future<Either<Failure, BannerModel>> getBannerById(String bannerId);
  Future<Either<Failure, void>> trackBannerClick(String bannerId);
  Future<Either<Failure, void>> trackBannerImpression(String bannerId);
  Future<List<BannerModel>> getCachedBanners();
}