import 'package:get_it/get_it.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';
import 'package:testapp/web_api/services/api_service.dart';

void setupDependencyInjection() {
  GetIt.I.registerLazySingleton(
    () => ApiService(),
  );
  GetIt.I.registerLazySingleton(() => OrdersConnection(),);
}