import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/injection.config.dart';

final GetIt getIt = GetIt.I;
//todo document This dependency injection
@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}
