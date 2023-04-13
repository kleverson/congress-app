import 'package:congress/core/app_colors.dart';
import 'package:congress/models/deputados.dart';
import 'package:congress/screen/detail_screen.dart';
import 'package:congress/service/deputado_service.dart';
import 'package:congress/widget/custom_app.dart';
import 'package:congress/widget/custom_future_builder.dart';
import 'package:flutter/material.dart';

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
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
              backgroundColor: AppColors.primary,
              title:!_searchBoolean ?  const Text("Deputados") : _searchTextField(),
              actions: !_searchBoolean
                  ? [
                IconButton(
                    icon:  const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                      });
                    })
              ] : [
                IconButton(
                    icon:  const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                      });
                    }
                )
              ]
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:16.0),
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
                  return _item(list[index]);
                }
            );
          },

          onLoading: (context) => Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }

  Widget _item(Deputados item){
    if(item != null){
      return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
          child: InkWell(
            onTap: (){
              print(item.uri);
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child:Image.network(item.urlFoto.toString(), width:92),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.nome.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                    fontSize: 16.0
                                )
                            ),
                            const SizedBox(height: 5.0),
                           Text(
                              item.siglaPartido.toString() + "/"+item.siglaUf.toString(),
                              style:  const TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 14.0),
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
                                  builder: (context) => DetailScreen(item: item)
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
    }else{
      return Container();
    }

  }
}
