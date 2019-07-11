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
    AirResult result;
    var response = await http.get(
        'http://api.airvisual.com/v2/nearest_city?key=25934421-978b-4c4d-8dce-7c7b108c9800');
    print('fetchData 호출 ${response.body}');
    var jsonData = json.decode(response.body);
    print('jsonData 호출 ${jsonData['status']}');
    if (jsonData['status'] == 'success') {
      result = AirResult.fromJson(jsonData);
    }
    return result;
  }

  void fetch() async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult$ => _airSubject.stream;

  void refresh() {
      fetch();
  }
}
