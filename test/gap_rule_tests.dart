// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gaprule/utils/json_loader.dart';
import 'package:gaprule/utils/search_results_helper.dart';

import 'assets/mock.dart';

void main() {
  Mock mock = Mock();

  test('JsonLoader fetches all campsites and reservations', () async {
    var parsedJson = await JsonLoader().loadJsonData(data: mock.getEncodedJson);

    expect(parsedJson['campsites'].length, mock.getNumberOfCampsites);
    expect(parsedJson['reservations'].length, mock.getNumberOfReservations);
  });

  test('SearchResultsHelper correctly maps each reservation to its campsite',
      () {
    SearchResultsHelper helper = SearchResultsHelper(
      data: mock.getCampsiteData,
      searchRange: mock.getSearchRange,
    );

    helper.run();
    expect(helper.getAllCampsites[0].reservations.length,
        mock.getAllReservationsForCampsite);
  });

  test('SearchResultsHelper returns correct number of open reservations', () {
    SearchResultsHelper helper = SearchResultsHelper(
      data: mock.getCampsiteData,
      searchRange: mock.getSearchRange,
    );

    helper.run();

    expect(helper.getAvailableCampsites.length, mock.getExpectedAvailability);
  });
}
