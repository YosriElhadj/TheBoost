// service_locator.dart

import 'package:get_it/get_it.dart';
import '../../data/repositories/auth_repository_mock.dart';
import '../../data/repositories/property_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/property_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/investments/get_properties_usecase.dart';
import 'auth_controller.dart';
import 'property_controller.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(),
  );
  
  // Add this line to register AuthRepository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryMock(), // This is a mock implementation for now
  );
  
  // Use cases
  getIt.registerLazySingleton(() => GetPropertiesUseCase(getIt<PropertyRepository>()));
  
  // Update these to use the registered AuthRepository
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  
  // Controllers
  getIt.registerLazySingleton(() => PropertyController(
    getPropertiesUseCase: getIt<GetPropertiesUseCase>(),
  ));
  
  getIt.registerLazySingleton(() => AuthController(
    loginUseCase: getIt<LoginUseCase>(),
    registerUseCase: getIt<RegisterUseCase>(),
  ));
}