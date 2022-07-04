import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';

abstract class GreezyService {
  Future<void> init(AppLanguageType languageType);
  Future<void> initMenuApi();

  List<MenuCardModel> getMenuForCard();
  MenuCardModel getMenuItemForCard(int id);
  MenuFileModel getMenuItem(int id);
}