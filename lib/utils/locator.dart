import 'package:get_it/get_it.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';


final serviceLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  serviceLocator
      .registerLazySingleton<DatabaseService>(() => DatabaseService());
        serviceLocator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl());

      //  serviceLocator
       
      // .registerLazySingleton(() => BaseViewmodel());
 

  // serviceLocator.registerLazySingleton<SignUpRepo>(() => SignUpImpl());

    
}
