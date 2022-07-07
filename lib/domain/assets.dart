import 'package:flutter/material.dart';
import 'package:greezy/domain/app_constants.dart';

import 'enums/enums.dart';

class Assets {
  static String dbPath = 'assets/db';
  static String imageBasePath = 'assets/images';
  static String svgsBasePath = 'assets/svgs';
  static String menuDbPath = '$dbPath/menu.json';
  static String popularMenuDbPath = '$dbPath/popular.json';
  static String featuredMenuDbPath = '$dbPath/featured.json';

  static String getImagePath(String name) => '$imageBasePath/$name';
  static String getSvgPath(String name) => '$svgsBasePath/$name';

  static String getImageCloudPath(String image) => '$digitalOceanUrl/$image';

  static String translateAppLanguageType(AppLanguageType language) {
    switch (language) {
      case AppLanguageType.english:
        return 'English';
      default:
        throw Exception('The provided app language type = $language is not valid');
    }
  }

  static String translateAutoThemeModeType(AutoThemeModeType type) {
    switch (type) {
      case AutoThemeModeType.on:
        return 'Follow OS setting';
      case AutoThemeModeType.off:
        return 'Off';
      default:
        throw Exception('Invalid auto theme mode type = $type');
    }
  }

  static AppThemeType translateThemeTypeBool(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
      default:
        throw Exception('Unknown error occurred');
    }
  }

  static String translateMenuFilterType(MenuFilterType type) {
    switch (type) {
      case MenuFilterType.name:
        return "Name";
      case MenuFilterType.price:
        return "Price";
      case MenuFilterType.rating:
        return "Rating";
      default:
        throw Exception('Invalid menu filter type = $type');
    }
  }

  static String translateSortDirectionType(SortDirectionType type) {
    switch (type) {
      case SortDirectionType.asc:
        return 'Ascending';
      case SortDirectionType.desc:
        return 'Descending';
      default:
        throw Exception('Invalid sort direction type = $type');
    }
  }

  static String translateMenuMealType(MenuMealType type) {
    switch (type) {
      case MenuMealType.breakfast:
        return "Breakfast";
      case MenuMealType.brunch:
        return "Brunch";
      case MenuMealType.lunch:
        return "Lunch";
      case MenuMealType.dinner:
        return "Dinner";
      case MenuMealType.snack:
        return "Snack";
      case MenuMealType.teatime:
        return "Tea time";
      default:
        throw Exception('Invalid menu meal type = $type');
    }
  }

  static IconData translateMenuMealTypeIcon(MenuMealType type) {
    switch (type) {
      case MenuMealType.breakfast:
        return Icons.breakfast_dining_outlined;
      case MenuMealType.brunch:
        return Icons.brunch_dining_outlined;
      case MenuMealType.lunch:
        return Icons.lunch_dining_outlined;
      case MenuMealType.dinner:
        return Icons.dinner_dining_outlined;
      case MenuMealType.snack:
        return Icons.emoji_events_outlined;
      case MenuMealType.teatime:
        return Icons.ac_unit_outlined;
      default:
        throw Exception('Invalid menu meal type = $type');
    }
  }

  static String translateMenuDishType(MenuDishType type) {
    switch (type) {
      case MenuDishType.biscuitsAndCookies:
        return "Biscuits and Cookies";
      case MenuDishType.bread:
        return "Bread";
      case MenuDishType.cereals:
        return "Cereals";
      case MenuDishType.condimentsAndSauces:
        return "Condiments and Sauces";
      case MenuDishType.desserts:
        return "Desserts";
      case MenuDishType.drinks:
        return "Drinks";
      case MenuDishType.mainCourse:
        return "Main course";
      case MenuDishType.pancake:
        return "Pancake";
      case MenuDishType.preps:
        return "Preps";
      case MenuDishType.preserve:
        return "Preserve";
      case MenuDishType.salad:
        return "Salad";
      case MenuDishType.sandwiches:
        return "Sandwiches";
      case MenuDishType.sideDish:
        return "Side dish";
      case MenuDishType.soup:
        return "Soup";
      case MenuDishType.starter:
        return "Starter";
      case MenuDishType.sweets:
        return "Sweets";
      case MenuDishType.egg:
        return "Egg";
      case MenuDishType.christmas:
        return "Christmas";
      case MenuDishType.specialOccasions:
        return "Special occasions";
      default:
        throw Exception('Invalid menu dish type = $type');
    }
  }
}