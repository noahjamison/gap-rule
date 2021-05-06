import 'package:flutter/material.dart';
import 'package:gaprule/models/campsite_model.dart';

/// [BookingSuccesScreen]
///
/// Shows the user a success message when they book a campsite.
class BookingSuccessScreen extends StatelessWidget {
  BookingSuccessScreen({required this.campsite});

  final CampsiteModel campsite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250.0,
              width: 250.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  this.campsite.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Booked!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
