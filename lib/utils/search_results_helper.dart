import 'package:flutter/material.dart';
import 'package:gaprule/constants.dart';
import 'package:gaprule/models/campsite_model.dart';
import 'package:gaprule/models/reservation_model.dart';

/// [SearchResultsHelper]
///
/// Loads campsite and reservation data from JSON file to list available campsites.
class SearchResultsHelper {
  SearchResultsHelper({required this.data, required this.searchRange});

  /// Parsed JSON object of campsite and reservation data.
  Map<String, dynamic> data;

  /// User's entered search range.
  DateTimeRange searchRange;

  /// All campsites from JSON file.
  List<CampsiteModel> _campsites = [];

  /// Which campsites are open given user's search range.
  List<CampsiteModel> _availableCampsites = [];

  /// All reservations from JSON file.
  List<ReservationModel> _bookedReservations = [];

  /// Returns all campsites, booked and available.
  List<CampsiteModel> get getAllCampsites {
    return this._campsites;
  }

  /// Returns campsites open for booking.
  List<CampsiteModel> get getAvailableCampsites {
    return this._availableCampsites;
  }

  /// Runs all required methods.
  run() {
    _loadAllReservations();
    _loadAllCampsites();
    _checkAvailability();
  }

  /// Stores all reservations from Json file into state.
  _loadAllReservations() {
    for (var reservation in this.data['reservations']) {
      // Note, the date needs to be in UTC format and the time set to 0
      this._bookedReservations.add(
            ReservationModel(
              campsiteId: reservation['campsiteId'].toString(),
              startDate: DateTime.parse('${reservation['startDate']} 00:00:00Z')
                  .toUtc(),
              endDate:
                  DateTime.parse('${reservation['endDate']} 00:00:00Z').toUtc(),
            ),
          );
    }
  }

  /// Stores all campsites from Json file into state.
  _loadAllCampsites() {
    for (var campsite in this.data['campsites']) {
      List<DateTimeRange> currentCampsiteReservations =
          _findReservationsForCampsite(campsite['id'].toString());

      this._campsites.add(
            CampsiteModel(
              id: campsite['id'].toString(),
              name: campsite['name'],
              image: campsite['image'],
              reservations: currentCampsiteReservations,
            ),
          );
    }
  }

  /// Returns list of reservation times for given campsite.
  List<DateTimeRange> _findReservationsForCampsite(id) {
    List<DateTimeRange> reservations = [];

    for (var i = 0; i < this._bookedReservations.length; i++) {
      var reservation = this._bookedReservations[i];

      // Found a reservation for current campsite
      if (reservation.campsiteId == id) {
        reservations.add(
          DateTimeRange(
            start: reservation.startDate,
            end: reservation.endDate,
          ),
        );
      }
    }

    return reservations;
  }

  /// Iterates through each campsite to check its availability.
  _checkAvailability() {
    for (var campsite in this._campsites) {
      bool isOpen = _isCampsiteAvailable(campsite);

      if (isOpen) {
        this._availableCampsites.add(campsite);
      }
    }
  }

  /// Returns whether or not given campsite is open for booking.
  bool _isCampsiteAvailable(CampsiteModel campsite) {
    // Assuming that reservations are already sorted
    for (DateTimeRange reservation in campsite.reservations) {
      var start = searchRange.start;
      var end = searchRange.end;

      // Will be positive if reservation end is after search start
      var endDiffFromStart2 = reservation.end.difference(start).inDays;

      // Will be negative if reservation start is before search end
      var startDiffFromEnd2 = reservation.start.difference(end).inDays;

      // Make sure there is no overlapping between date ranges
      if (start.isBefore(reservation.end) && end.isAfter(reservation.start)) {
        return false;
      }

      // Enforce gap rule
      if (endDiffFromStart2.abs() == 1 + kGapRule) {
        return false;
      } else if (startDiffFromEnd2.abs() == 1 + kGapRule) {
        return false;
      }
    }
    return true;
  }
}
