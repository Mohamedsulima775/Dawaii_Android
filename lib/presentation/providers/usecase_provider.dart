
import 'package:dawaii/core/network/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/medication/add_medication_usecase.dart';
//import '../../domain/repositories/medication_repository.dart';
import '../../data/repositories/medication_repository_impl.dart';
import '../../data/data_sources/remote/medication_api.dart';
import '../../data/data_sources/local/local_storage.dart';

final medicationApiProvider = Provider((ref) => MedicationApi(ApiClient as ApiClient));
final localStorageProvider = Provider((ref) => LocalStorage(SharedPreferences as SharedPreferences));

final medicationRepositoryProvider = Provider<MedicationRepository>((ref) {
  return MedicationRepository(
    ref.read(medicationApiProvider),
    ref.read(localStorageProvider),
  );
});

final addMedicationUseCaseProvider = Provider<AddMedicationUseCase>((ref) {
  return AddMedicationUseCase(
    ref.read(medicationRepositoryProvider),
  );
});



