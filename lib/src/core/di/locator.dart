import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../config/environment.dart';

final locator = GetIt.instance..allowReassignment = true;

void setupLocator(Environment environment) {
  locator.registerSingleton(AppConfig(environment));
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: locator<AppConfig>().baseUrl)));
}
