import 'package:congress/core/app_colors.dart';
import 'package:congress/screen/detail_screen.dart';
import 'package:congress/service/deputado_service.dart';
import 'package:congress/widget/custom_app.dart';
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
  var service = DeputadoService();
  bool _searchBoolean = false;
  String name = "";
  late Future<List<Deputados>> _loadItens;


  @override
  void initState() {
    _loadItens = service.getList(name) as Future<List<Deputados>>;
    super.initState();
  }


  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          print(s);
          name = s;
          _loadItens;
          // _searchIndexList = [];
          // for (int i = 0; i < _list.length; i++) {
          //   if (_list[i].contains(s)) {
          //     _searchIndexList.add(i);
          //   }
          // }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)
        ),
        hintText: 'Buscar por nome',
        hintStyle: const TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title:!_searchBoolean ? Text("Deputados") : _searchTextField(),
          actions: !_searchBoolean
                ? [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                    });
                  })
            ]
                : [
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = false;
                    });
                  }
              )
            ]
        ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical:16.0),
        child: CustomFutureBuilder<List<Deputados>>(
          future: _loadItens,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    child: InkWell(
                      onTap: (){
                        print(list[index].uri);
                      },
                      child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child:Image.network(list[index].urlFoto.toString(), width:92),
                              ),
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(list[index].nome.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.black,
                                            fontSize: 16.0
                                        )
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      list[index].siglaPartido.toString() + "/"+list[index].siglaUf.toString(),
                                      style: TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 14.0),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                  primary: AppColors.gray100,
                                  onPrimary: AppColors.black,
                                  textStyle: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400
                                  )
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(item: list[index])
                                      )
                                  );
                                },
                                child: const Text(
                                  "Detalhes"
                                ),
                              )
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
