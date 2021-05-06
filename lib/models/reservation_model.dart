/// [ReservationModel]
///
/// Models a campsite's reservation.
class ReservationModel {
  ReservationModel(
      {required this.campsiteId,
      required this.startDate,
      required this.endDate});

  final String campsiteId;
  final DateTime startDate;
  final DateTime endDate;
}
