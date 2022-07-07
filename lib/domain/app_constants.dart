import 'assets.dart';
import 'enums/enums.dart';
import 'models/models.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

const digitalOceanUrl = 'https://greezy.sfo3.digitaloceanspaces.com/menu';

class Data {
  static List<SplashData> splashData = [
    SplashData(
      image: Assets.getSvgPath("online_groceries.svg"),
      title: "Welcome!",
      text: "Welcome to Greezy, let's help you order!",
    ),
    SplashData(
      image: Assets.getSvgPath("ice_cream.svg"),
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

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp = RegExp(r"^[0-9]");
const String kEmailNullError = "Please enter your email.";
const String kFirstNameNullError = "Please enter your first name.";
const String kAddressNullError = "Please enter your address.";
const String kLastNameNullError = "Please enter your last name.";
const String kPhoneNumberNullError = "Please enter your phone number.";
const String kInvalidPhoneNumberError = "Please enter a valid phone number. Signs not necessary.";
const String kInvalidEmailError = "Please enter a valid email.";
const String kPassNullError = "Please enter your password.";
const String kPassMatchNullError = "Password does not match.";
const String kShortPassError = "Password should be longer than 8 characters.";
const String kConfirmPassNullError = "Please confirm your password.";

const String constantDescription = "This meal was prepared top quality ingredients in order to provide you our customer, with the best dining experience. Click on order to process your purchase.";

const infoA = "You can add new credit cards that help you process purchases.";
const infoB = "You cannot make edits to already created cards.";
const infoC = "You can delete a card by sliding it off the tile";