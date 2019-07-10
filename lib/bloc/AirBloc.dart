import 'package:flutter_dust/model/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var response = await http.get(
        'http://api.airvisual.com/v2/nearest_city?key=25934421-978b-4c4d-8dce-7c7b108c9800');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  void fetch() async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult$ => _airSubject.stream;
}
