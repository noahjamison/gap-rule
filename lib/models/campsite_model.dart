import 'package:flutter/material.dart';

/// [CampsiteModel]
///
/// Models a campsite and it's reservations.
class CampsiteModel {
  CampsiteModel({
    required this.id,
    required this.name,
    required this.image,
    required this.reservations,
  });

  final String id;
  final String name;
  final String image;

  final List<DateTimeRange> reservations;
}
