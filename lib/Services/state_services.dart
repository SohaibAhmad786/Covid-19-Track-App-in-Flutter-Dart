import 'dart:convert';

import 'package:covid_19_app/Model/countries_list_model.dart';
import 'package:covid_19_app/Model/world_states_model.dart';
import 'package:covid_19_app/Services/Utilities/app_url.dart';

import 'package:http/http.dart' as http;

class WorldStateService {
  // ignore: non_constant_identifier_names
  Future<WorldState> FetchWorldStateRecord() async {
    try {
      final response =
          await http.get(Uri.parse(AppUrl.worldStatesApi.toString()));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return WorldState.fromJson(data);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<dynamic>> fetchCountriesListRecord() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList.toString()));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception("error");
    }
  }
}
