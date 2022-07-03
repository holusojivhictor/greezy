import 'package:get_it/get_it.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);
  }
}