import 'package:flutter/material.dart';
import 'package:gaprule/screens/calendar_screen.dart';

void main() {
  runApp(GapRule());
}

class GapRule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: CalendarScreen.id,
      routes: {
        CalendarScreen.id: (context) => CalendarScreen(),
      },
    );
  }
}
