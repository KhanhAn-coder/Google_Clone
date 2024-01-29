import 'dart:convert';
import 'package:google_clone/config/api_keys.dart';
import 'package:http/http.dart' as http;

import '../config/api_json.dart';

class ApiService{
  bool isDummyData = false;
  Future<Map<String,dynamic>> fetchData({required String queryTerm, String start = "0"}) async {
    try{
      if(!isDummyData){
        String q = queryTerm.contains(' ') ? queryTerm.split(' ').join('%20') : queryTerm;
        //Khanh An => Khanh%20An for google can understand

        final response = await http.get(
          Uri.parse(
              'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$contextKey&q=$q&start=$start'),
        );
        if(response.statusCode == 200){
          final jsonData = response.body;
          final respData = jsonDecode(jsonData);
          return respData;
        }
      }

    }catch(e){
      print(e.toString());
    }
    return apiResponse;
  }
}