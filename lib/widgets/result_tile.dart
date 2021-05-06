import 'package:flutter/material.dart';
import 'package:gaprule/constants.dart';
import 'package:gaprule/models/campsite_model.dart';
import 'package:gaprule/screens/booking_success_screen.dart';
import 'package:gaprule/widgets/rounded_button.dart';
import 'package:intl/intl.dart';

class ResultTile extends StatelessWidget {
  final CampsiteModel campsite;
  final DateTimeRange searchRange;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  ResultTile({required this.campsite, required this.searchRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 175.0,
              width: 175.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  this.campsite.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.campsite.name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${kMonths[searchRange.start.month - 1]} ${searchRange.start.day} - ${searchRange.end.day}',
                  ),
                  RoundedButton(
                    color: Colors.green,
                    title: 'Book Now',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSuccessScreen(
                            campsite: this.campsite,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
