import 'package:get_it/get_it.dart';
import 'package:giftpose/screens/authentication/repo/authentication_repo.dart';
import 'package:giftpose/screens/authentication/repo/authentication_repo_impl.dart';

import 'package:giftpose/screens/main_view/repo/main_view_repo.dart';
import 'package:giftpose/screens/main_view/repo/main_view_repo_impl.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo_impl.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo_impl.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';

final serviceLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  serviceLocator.registerLazySingleton<DatabaseService>(
    () => DatabaseService(),
  );
  serviceLocator.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );

  //  serviceLocator

  // .registerLazySingleton(() => BaseViewmodel());

  serviceLocator.registerLazySingleton<OnboardingRepo>(
    () => OnboardingRepoImpl(),
  );
  serviceLocator.registerLazySingleton<MainViewRepo>(() => MainViewRepoImpl());
  serviceLocator.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationRepoImpl(),
  );
  serviceLocator.registerLazySingleton<RequesterRepo>(
    () => RequesterRepoImpl(),
  );
}
