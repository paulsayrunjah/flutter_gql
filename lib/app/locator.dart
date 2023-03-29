import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_gql/app/locator.config.dart';

final locator = GetIt.instance;

@injectableInit
void setUpLocator() => locator.init();
