import 'package:get_it/get_it.dart';
import 'package:greezy/application/bloc.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static MenuItemBloc get menuItemBloc {
    final greezyService = getIt<GreezyService>();
    final dataService = getIt<DataService>();
    return MenuItemBloc(greezyService, dataService);
  }

  static CreditCardsBloc get creditCardsBloc {
    final dataService = getIt<DataService>();
    return CreditCardsBloc(dataService);
  }

  static CreditCardBloc getCreditCardBloc(CreditCardsBloc bloc) {
    final dataService = getIt<DataService>();
    final loggingService = getIt<LoggingService>();
    return CreditCardBloc(dataService, loggingService, bloc);
  }

  static Future<void> init() async {
    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);

    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);
    
    getIt.registerSingleton<GreezyService>(GreezyServiceImpl());

    final dataService = DataServiceImpl(getIt<GreezyService>());
    await dataService.init();
    getIt.registerSingleton<DataService>(dataService);

    final firebaseDataService = FirebaseDataServiceImpl();
    getIt.registerSingleton<FirebaseDataService>(firebaseDataService);
  }
}