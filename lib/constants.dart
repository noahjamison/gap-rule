/// Current gap rule length in days.
int kGapRule = 1;

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year - 3, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

List kMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
