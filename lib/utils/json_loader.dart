import 'dart:async' show Future;
import 'dart:convert';

/// [JsonLoader]
///
/// Converts raw JSON to Map
class JsonLoader {
  Future<dynamic> loadJsonData({required String data}) async {
    var parsedJson = json.decode(data);
    return parsedJson;
  }
}
