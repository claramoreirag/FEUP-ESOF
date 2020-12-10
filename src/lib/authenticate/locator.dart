import 'package:get_it/get_it.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:hello/authenticate/authenticationService.dart';
import 'package:hello/authenticate/firestoreService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
