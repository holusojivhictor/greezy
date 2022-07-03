import 'assets.dart';
import 'enums/enums.dart';
import 'models/models.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

class Data {
  static List<SplashData> splashData = [
    SplashData(
      image: Assets.getSvgPath("ice_cream.svg"),
      title: "Welcome!",
      text: "Welcome to Greezy, let's help you order!",
    ),
    SplashData(
      image: Assets.getSvgPath("online_groceries.svg"),
      title: "Take control of your food life",
      text: "We help people connect with food stores \naround their states",
    ),
    SplashData(
      image: Assets.getSvgPath("tasting.svg"),
      title: "Best online experience",
      text: "We show the easy way to order. \nJust stay at home with us",
    ),
  ];
}

/// Languages map
const languagesMap = {
  AppLanguageType.english: LanguageModel('en', 'US'),
};