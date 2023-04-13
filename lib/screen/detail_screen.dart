import 'package:congress/core/app_colors.dart';
import 'package:congress/models/deputados.dart';
import 'package:congress/widget/custom_app.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.item}) : super(key: key);

  final Deputados item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomApp().BarApp(widget.item.nome.toString()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical:14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child:Image.network(
                          widget.item.urlFoto.toString(),
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.item.nome.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),

                ],
              ),
              block("Dados"),
              SizedBox(height:100),
              block("Despesas"),
              SizedBox(height:100),
              block("Discursos"),
              SizedBox(height:100),
              block("Eventos"),
              SizedBox(height:100),
              block("Frentes"),
              SizedBox(height:100),
              block("Ocupações"),
            ],
          ),
        )
      ),
    );
  }

  block(String title){
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        child:Column(
          children: [
            Text(
              title,
              style:TextStyle(
                color: AppColors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.w700
              )),
              Container(
                child: Center(
                  child: Text("lorem ipsum"),
                ),
              )
            ],
        )
      );
  }
}
