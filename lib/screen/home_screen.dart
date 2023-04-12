import 'package:congress/service/deputado_service.dart';
import 'package:congress/widget/custom_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/deputados.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<Deputados>> _loadItens;
  var service = DeputadoService();

  @override
  void initState(){

    _loadItens = service.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deputados"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical:16.0),
        child: CustomFutureBuilder<List<Deputados>>(
          future: service.getList(),
          onEmpty: (context){
            return Center(child: Text('No Data'));
          },

          onError: (context, error){
            return Center(child: Text(error.toString()));
          },

          onComplete: (context, list){
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index){
                  return Card(
                    child: InkWell(
                      onTap: (){
                        print(list[index].uri);
                      },
                      child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(list[index].urlFoto.toString(), width: 50),
                              Column(
                                children: [
                                  Text(list[index].nome.toString()),
                                  Text(list[index].email.toString())
                                ],
                              )

                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(list[index].siglaPartido.toString() + "/"+list[index].siglaUf.toString() , style: TextStyle(color: Colors.blue)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                  );
                }
            );
          },

          onLoading: (context) => Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
