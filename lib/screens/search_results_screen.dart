import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaprule/models/campsite_model.dart';
import 'package:gaprule/utils/json_loader.dart';
import 'package:gaprule/utils/search_results_helper.dart';
import 'package:gaprule/widgets/result_tile.dart';

/// [SearchResultsScreen]
///
/// Shows the user the available campsites for the dates they selected.
class SearchResultsScreen extends StatefulWidget {
  SearchResultsScreen({required this.searchRange});

  final DateTimeRange searchRange;

  @override
  _SearchResultsScreenState createState() =>
      _SearchResultsScreenState(searchRange: searchRange);
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  _SearchResultsScreenState({required this.searchRange});

  final DateTimeRange searchRange;
  List<CampsiteModel> availableCampsites = [];

  @override
  void initState() {
    super.initState();

    runSearch();
  }

  /// Finds all campsites open for booking within search range.
  runSearch() async {
    // Load test-case.json file from asset folder
    var rawJson = await rootBundle.loadString('assets/test-case.json');
    var parsedJson = await JsonLoader().loadJsonData(data: rawJson);

    SearchResultsHelper helper = SearchResultsHelper(
      data: parsedJson,
      searchRange: this.searchRange,
    );

    helper.run();

    setState(() {
      this.availableCampsites = helper.getAvailableCampsites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Availability'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.0),
          Expanded(
            child: ListView.builder(
              itemCount: this.availableCampsites.length,
              itemBuilder: (BuildContext context, int index) {
                return ResultTile(
                  campsite: this.availableCampsites[index],
                  searchRange: searchRange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
