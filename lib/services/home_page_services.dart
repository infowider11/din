import 'dart:math';

import 'package:din/services/webservices.dart';

import 'api_urls.dart';

class SearchingServices {
  static Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    var request = {
      'search_text': query
    };
    // setState(() {
    //
    // });
    var jsonResponse = await Webservices.postData(
      apiUrl:  ApiUrls.getDamsList,
      isGetMethod: true,
      request: request,
    );
    print('the status is ${jsonResponse}');
    List searchSuggestions = jsonResponse['data']['data'];
    print('the search list is $searchSuggestions');
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(searchSuggestions.length, (index) {
      return searchSuggestions[index];
      return {
        'name': query + index.toString(),
        'price': Random().nextInt(100).toString()
      };
    });
  }
}