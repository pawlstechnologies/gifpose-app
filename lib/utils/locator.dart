import 'package:get_it/get_it.dart';


final serviceLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  serviceLocator
      .registerLazySingleton<DatabaseService>(() => DatabaseService());

       serviceLocator
       
      .registerLazySingleton(() => BaseViewmodel());
 

  // serviceLocator.registerLazySingleton<SignUpRepo>(() => SignUpImpl());

    
}
