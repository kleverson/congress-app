import 'package:dio/dio.dart';

import '../models/deputados.dart';

class DeputadoService{

  Future<List<Deputados>> getList(String? name) async{
    List<Deputados> list  = <Deputados>[];
    final dio = Dio();
    var url = "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome";
    if(name!.isNotEmpty){
      url = url + "&nome="+name.toString();
    }
    var response = await dio.get(url, options: Options(
        contentType: 'application/json'
    ));

    var r = response.data["dados"];

    for(var item in r){
      list.add(Deputados.fromJson(item));
    }

    return list;
  }

}