import 'dart:convert';

import 'package:flutter/material.dart';

/// [Mock]
///
/// A Mock class used for testing.
class Mock {
  /// Mock campsite data.
  String _data = jsonEncode({
    "campsites": [
      {"id": 1, "name": "Cozy Cabin", "image": "images/cozy-cabin.jpeg"},
      {
        "id": 5,
        "name": "Cabin in the Woods",
        "image": "images/cabin-in-the-woods.jpeg"
      }
    ],
    "reservations": [
      {"campsiteId": 1, "startDate": "2018-06-01", "endDate": "2018-06-03"},
      {"campsiteId": 1, "startDate": "2018-06-08", "endDate": "2018-06-10"},
      {"campsiteId": 2, "startDate": "2018-06-01", "endDate": "2018-06-01"},
      {"campsiteId": 2, "startDate": "2018-06-02", "endDate": "2018-06-03"}
    ]
  });

  /// Returns total number of campsites in Mock.
  int get getNumberOfCampsites {
    return jsonDecode(this._data)['campsites'].length;
  }

  /// Returns total number of reservations in Mock
  int get getNumberOfReservations {
    return jsonDecode(this._data)['reservations'].length;
  }

  /// Returns mock data as encoded JSON.
  String get getEncodedJson {
    return this._data;
  }

  /// Returns mock data as decoded JSON.
  Map<String, dynamic> get getCampsiteData {
    return jsonDecode(this._data);
  }

  /// Returns mock search range.
  DateTimeRange get getSearchRange {
    return this._searchRange;
  }

  /// Expected number of reservations for campsites.id["1"] in mock data
  /// update this if reservations are added or removed from mock JSON.
  int get getAllReservationsForCampsite {
    return 2;
  }

  /// Expected number of open campsites using mock's search range and listed
  /// reservations. Update if reservations are added or removed from mock JSON.
  int get getExpectedAvailability {
    return 2;
  }

  // Search Range from June 4, 2018 - June 6, 2018
  DateTimeRange _searchRange = DateTimeRange(
    start: DateTime(2018, 6, 4),
    end: DateTime(2018, 6, 6),
  );
}
