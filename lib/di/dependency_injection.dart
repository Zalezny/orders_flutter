import 'package:get_it/get_it.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import 'package:orderskatya/web_api/services/api_service.dart';

void setupDependencyInjection() {
  GetIt.I.registerLazySingleton(
    () => ApiService(),
  );
  GetIt.I.registerLazySingleton(
    () => OrdersConnection(),
  );
}
