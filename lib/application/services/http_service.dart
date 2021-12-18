import 'dart:convert';

import 'package:patealo/domain/abstracts/service.dart';
import 'package:patealo/domain/entities/pictogram.dart';
import 'package:http/http.dart' as http;

class HttpService extends Service {

  HttpService._();

  static final HttpService fetch = HttpService._();

  final String _url = 'https://api.arasaac.org/api/pictograms';


  @override
  Future<Pictogram> getPictogram(int id) async {
    http.Response response = await http.get(Uri.parse('$_url/es/$id'));

    if(response.statusCode == 200) {
      return Pictogram.fromJson(response.body);
    } else {
      throw Exception('Failed to fetch pictogram');
    }
  }

  @override
  Future<List<Pictogram>> getPictograms() async {
    http.Response response = await http.get(Uri.parse('$_url/all/es'));

    if(response.statusCode == 200) {
      return json.decode(response.body).map<Pictogram>((pictogram) => Pictogram.fromMap(pictogram)).toList();
    } else {
      throw Exception('Failed to fetch pictograms');
    }
  }
}
