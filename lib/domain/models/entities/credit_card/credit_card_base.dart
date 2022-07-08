abstract class CreditCardBase {
  DateTime get createdAt;

  String get cardNumber;
  set cardNumber(String value);

  String get cardSecurityCode;
  set cardSecurityCode(String value);

  String get cardExpiryDate;
  set cardExpiryDate(String value);

  String get cardHolderName;
  set cardHolderName(String value);

  String get bankName;
  set bankName(String value);

  int get cardType;
  set cardType(int value);

  double get startBalance;
  set startBalance(double value);

  double get usedCredit;
  set usedCredit(double value);
}