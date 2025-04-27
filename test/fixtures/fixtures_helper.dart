import 'dart:convert';
import 'dart:io';

class FixturesHelper {
  static String readFixture(String fixturePath) {
    return File("test/fixtures/$fixturePath").readAsStringSync();
  }

  static dynamic decodeFicture(String fixturePath) {
    return json.decode(readFixture(fixturePath));
  }

  static String normalizeJson(String jsonContent) {
    return json.encode(json.decode(jsonContent));
  }
}
