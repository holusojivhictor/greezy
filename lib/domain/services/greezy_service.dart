import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';

abstract class GreezyService {
  Future<void> init(AppLanguageType languageType);
  Future<void> initMenuApi();
  Future<void> initFeaturedMenuApi();
  Future<void> initPopularMenuApi();

  List<MenuCardModel> getMenuForCard();
  MenuCardModel getMenuItemForCard(int id);
  MenuFileModel getMenuItem(int id);

  List<MenuCardModel> getFeaturedMenuForCard();
  MenuCardModel getFeaturedMenuItemForCard(int id);

  String getParsedTime();

  UserModel getUserProfile();
  String getUserName();

  List<MenuCardModel> getPopularMenuForCard();
  MenuCardModel getPopularMenuItemForCard(int id);
}