import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/cubit/marvel_state.dart';
import 'package:marvel/model/marvel_model.dart';

abstract class MarvelRepository {
  Future<MarvelModel> getAll();
}

class MarvelRepositoryImplementation implements MarvelRepository {
  late final BuildContext context;

  MarvelRepositoryImplementation(this.context);
  @override
  Future<MarvelModel> getAll() async {
    var client = http.Client();
    String url = "https://mcuapi.herokuapp.com/api/v1/movies";

    var response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return MarvelModel.fromJson(jsonResponse);
    } else {
      throw MarvelError("Erro");
    }
  }
}
