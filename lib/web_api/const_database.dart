
class ConstDatabase {
  static String get keyAuth {
    return "";
  }

  static String get orderUrl {
    return "";
  }
  static String dynamicOrderUrl(String id) {
    return "$orderUrl$id";
  }
}