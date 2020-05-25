class Helper {
  static Map<String, num> jsonToMap(Map<String, dynamic> json) {
    return json != null ? Map<String, num>.from(json) : null;
  }

  static DateTime getDateTimeFromUnixTimeMS(int unixTime) {
    return DateTime.fromMillisecondsSinceEpoch(unixTime);
  }
}