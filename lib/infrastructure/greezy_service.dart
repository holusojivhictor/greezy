import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/app_language_type.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

class GreezyServiceImpl implements GreezyService {
  late MenuFile _menuFile;

  @override
  Future<void> init(AppLanguageType languageType) async {
    await Future.wait([
      initMenuApi(),
    ]);
  }

  @override
  Future<void> initMenuApi() async {
    final jsonStr = await rootBundle.loadString(Assets.menuDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _menuFile = MenuFile.fromJson(json);
  }

  @override
  List<MenuCardModel> getMenuForCard() {
    return _menuFile.menu.map((e) => _toMenuItemForCard(e)).toList();
  }

  @override
  MenuFileModel getMenuItem(int id) {
    return _menuFile.menu.firstWhere((element) => element.id == id);
  }

  @override
  MenuCardModel getMenuItemForCard(int id) {
    final menuItem = _menuFile.menu.firstWhere((element) => element.id == id);
    return _toMenuItemForCard(menuItem);
  }

  MenuCardModel _toMenuItemForCard(MenuFileModel menu) {
    return MenuCardModel(
      id: menu.id,
      title: menu.title,
      price: menu.price,
      image: menu.image,
      rating: menu.rating.rate,
      ratingCount: menu.rating.count,
      dishType: menu.dishType,
    );
  }
}