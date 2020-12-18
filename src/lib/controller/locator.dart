import 'package:get_it/get_it.dart';
import 'package:hello/controller/authenticationService.dart';
import 'package:hello/controller/firestoreService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
