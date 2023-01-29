
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_deneme/models/akademisyen.dart';
import 'package:get/get_core/src/get_main.dart';
class Akademisyen extends StatefulWidget {
  const Akademisyen({super.key});

  @override
  State<Akademisyen> createState() => _AkademisyenState();
}

class _AkademisyenState extends State<Akademisyen> {
  TextEditingController adController = TextEditingController();
  List<AkademisyenModel> akalar = [];
  // data ekleme veritabanına 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAka();
    FirebaseFirestore.instance.collection("akademisyen").
    snapshots(

    ).listen((records) { 
      mapAka(records);
    });
  }
  fetchAka()async{
    var records = await FirebaseFirestore.instance.collection("akademisyen").get();
    mapAka(records);
  }
  mapAka(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
    setState(() {
      akalar = list;
    });
  }

  ekleAka() async{
    var yeni = AkademisyenModel(ad: adController.text, akaId: "id", sifre: "123");
    await FirebaseFirestore.instance.collection("akademisyen").add(yeni.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Akademisyen Ekle')),


     body: Center(
       child: Column(children: [
        SizedBox(height: 200,),
        Text('Akademisyen Adı',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: adController,
           ),
         ),
                  SizedBox(height: 30,),

     
         ElevatedButton(onPressed: (){
     
          print(adController.text);
          ekleAka();
          
         }, child: Text('Akademisyen Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
         SizedBox(height: 30,),
         SingleChildScrollView(
           child: Container(
            width: double.infinity,
            height: 200,
            
            child: ListView.builder(
              itemCount: akalar.length,
              itemBuilder: (BuildContext context,index){
            return ListTile(
              onTap: (){},
              title: Text(akalar[index].ad),
            );
           })
           ,),
         )
     
     
     
         
       ],),
     )
    );
  }
}