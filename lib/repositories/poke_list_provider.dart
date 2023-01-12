import 'package:http/http.dart' as http;

class PokeListProvider {

  Future<dynamic> getPokeInfo({required int pokeId}) async {
    final Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$pokeId");
    var res = await http.get(url);
    return res;
  }
}
