import 'package:brasserie_ts_mobile/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("dateTimeToDayMonthYear", () {
    test(
      "should return 21/03/2005 when a coresponding DateTime is provided",
      () {
        // arrange
        final tExpectedResult = "21/03/2005";
        final tDateTime = DateTime(2005, 3, 21, 8, 27, 36);

        // act
        final res = DateFormatter.dateTimeToDayMonthYear(tDateTime);

        // assert
        expect(res, equals(tExpectedResult));
      },
    );
  });

  group("dateTimeToDayMonthYearHourMinSec", () {
    test(
      "should return 28/04/2025 08:02:47 when a corresponding DateTime is provided",
      () {
        // arrange
        final tExpectedResult = "28/04/2025 08:02:47";
        final tDateTime = DateTime(2025, 04, 28, 8, 2, 47);

        // act
        final res = DateFormatter.dateTimeToDayMonthYearHourMinSec(tDateTime);

        // assert
        expect(res, equals(tExpectedResult));
      },
    );
  });
}
