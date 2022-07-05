import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/app_language_type.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';
import 'package:greezy/presentation/shared/extensions/string_extensions.dart';

class GreezyServiceImpl implements GreezyService {
  late MenuFile _menuFile;
  late MenuFile _featuredMenuFile;
  late MenuFile _popularMenuFile;

  @override
  Future<void> init(AppLanguageType languageType) async {
    await Future.wait([
      initMenuApi(),
      initFeaturedMenuApi(),
      initPopularMenuApi(),
    ]);
  }

  @override
  Future<void> initMenuApi() async {
    final jsonStr = await rootBundle.loadString(Assets.menuDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _menuFile = MenuFile.fromJson(json);
  }

  @override
  Future<void> initFeaturedMenuApi() async {
    final jsonStr = await rootBundle.loadString(Assets.featuredMenuDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _featuredMenuFile = MenuFile.fromJson(json);
  }

  @override
  Future<void> initPopularMenuApi() async {
    final jsonStr = await rootBundle.loadString(Assets.popularMenuDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _popularMenuFile = MenuFile.fromJson(json);
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

  @override
  List<MenuCardModel> getFeaturedMenuForCard() {
    return _featuredMenuFile.menu.map((e) => _toMenuItemForCard(e)).toList();
  }

  @override
  MenuCardModel getFeaturedMenuItemForCard(int id) {
    final menuItem = _featuredMenuFile.menu.firstWhere((element) => element.id == id);
    return _toMenuItemForCard(menuItem);
  }

  @override
  List<MenuCardModel> getPopularMenuForCard() {
    return _popularMenuFile.menu.map((e) => _toMenuItemForCard(e)).toList();
  }

  @override
  MenuCardModel getPopularMenuItemForCard(int id) {
    final menuItem = _popularMenuFile.menu.firstWhere((element) => element.id == id);
    return _toMenuItemForCard(menuItem);
  }

  @override
  String getParsedTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'breakfast';
    } else if (hour < 17) {
      return 'lunch';
    } else {
      return 'dinner';
    }
  }

  @override
  UserModel getUserProfile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final provider in user.providerData) {
        final providerId = provider.providerId;
        final uid = provider.uid;
        final name = provider.displayName;
        final emailAddress = provider.email;

        return UserModel(providerId: providerId, uid: uid!, displayName: name!, emailAddress: emailAddress!);
      }
    }
    return UserModel(providerId: "", uid: "", displayName: "", emailAddress: "");
  }

  @override
  String getUserName() {
    final user = getUserProfile();
    final emailAddress = user.emailAddress;
    final split = emailAddress.split("@");
    final name = split[0];
    final userName = name.capitalize();
    return userName;
  }
}