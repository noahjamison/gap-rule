# GapRule
GapRule is a mobile app meant to implement the “gap” business rule. This rule prevents one day gaps in between calendar bookings. The app also doesn’t allow a user to book dates on a campsite that are already reserved.

## Running the Program
This app was designed for mobile (specifically an iPhone 11 Pro Max running iOS 14.4.2), however it should run on other screen sizes, versions, and even Android.

In order to run this app, you’ll have to download the [Flutter SDK](https://flutter.dev/docs/get-started/install).
Follow those steps to install and run the program.

### Running Tests
In the root project folder, run `flutter test test/gap_rule_tests.dart`.
 
## High-Level Description of Approach
I separated out two goals from the requirements:
1. Make sure new reservations don’t overlap with existing reservations.
2. Implement the “gap rule”.

I created classes to model a campsite and a reservation so the JSON data could be stored and manipulated easily.

Now that the data was transformed, I realized I would have to iterate over each campsites’ reservations and compare their dates to the dates in the search range. Working with two ranges of dates proved tricky until I realized that there would be no booking conflict if the start of the search range was after a reservation’s end date. Or inversely, if the end of the search range was before the start of the reservation. 

To enforce the “gap rule”, I compared the start of the search range the end of a reservation. If the difference in days between these two dates was the same, then that meant the gap rule was violated. I applied the same (somewhat reversed) logic to check the end of the search range too.

## Assumptions + Considerations
* I treated `test-case.json` as though it was data being returned from an API request.
* `”search"` is intentionally not being pulled from `test-case.json` because I thought this term should be decided by the client instead of coming through as a JSON response.
* Given that resort-owners may want to implement a gap-rule of varying days , I made a constant `kGapRule` that can easily be modified accordingly; although it is currently set to just  `1`.
* The `search dates` are defaulted to `June 4, 2018 - June 6, 2018` as I saw in `test-case.json` to make the app easier to use. However, these dates can be changed by tapping on different days.
* I followed Flutter’s style guide in that most code should be self-explanatory without needing additional comments. The UI code might look messy at first but that’s just Flutter!
* I didn’t add any exception handling for booking requests. It could be an issue in a real world application if two users were to try to book the same “available” dates at once. My thoughts were that, ideally, solving this shouldn’t be up to the client.
* `SearchResultsHelper` was designed to have an efficient runtime yet still be maintainable by other developers. Runtime could be improved but the code would be harder to read.
* The added line in `test-case.json` just links to a campsite image.
* Because the project was mall, I thought that a few unit tests would be sufficient.