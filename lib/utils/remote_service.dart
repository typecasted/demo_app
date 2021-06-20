
import 'package:http/http.dart' as http;
import 'package:demo_app/Model/data_model.dart';

class RemoteServices {
  static var client = http.Client();


  static Future<List<DataModel>?> fetchData() async {
    var response = await client.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/photos#'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return dataModelFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}