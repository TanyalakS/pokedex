import 'dart:convert';
import 'dart:developer';

import 'package:pokedex/model/poke_list_results.dart';
import 'package:pokedex/repositories/poke_list_provider.dart';

class PokeListRepository {
  final PokeListProvider pokeListProvider = PokeListProvider();

  Future<dynamic> getPokeInfo({required int pokeId}) async {
    try {
      var response = await pokeListProvider.getPokeInfo(pokeId: pokeId);
      //print('res before map is ok: $response');
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> pokeList = jsonDecode(json);
        json = PokeListResultsModel.fromJson(pokeList);
        //print('json $json');
        return json;
      } 
    } catch (e) {
      log(e.toString());
    }
    return json;
  }
}
