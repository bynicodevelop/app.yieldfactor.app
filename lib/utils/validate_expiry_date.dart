bool validateExpiryDate(
  String value,
  DateTime now,
) {
  String month = value.substring(0, 2);
  String year = value.substring(2, 4);

  String stringYear = now.year.toString().substring(2, 4);

  if (int.parse(month) >= now.month &&
      int.parse(year) >= int.parse(stringYear)) {
    return true;
  }

  return false;
}
