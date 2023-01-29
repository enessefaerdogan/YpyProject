
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_deneme/models/akademisyen.dart';
import 'package:flutter_deneme/models/ders.dart';
import 'package:flutter_deneme/models/tur.dart';
import 'package:get/get_core/src/get_main.dart';
class Dersekle extends StatefulWidget {
  const Dersekle({super.key});

  @override
  State<Dersekle> createState() => _DersekleState();
}

class _DersekleState extends State<Dersekle> {
  TextEditingController adController = TextEditingController();
  TextEditingController sinifController = TextEditingController();
  TextEditingController alanController = TextEditingController();
  
  
  List<AkademisyenModel> akalar = [];
  List<TurModel> turler = [];
  
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
    fetchTur();
    FirebaseFirestore.instance.collection("tur").
    snapshots(

    ).listen((records) { 
      mapTur(records);
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
  //fetch turler
   fetchTur()async{
    var records = await FirebaseFirestore.instance.collection("tur").get();
    mapAka(records);
  }
  mapTur(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
 TurModel(ad: item['ad'], id: item.id)).toList();
    setState(() {
      turler = list;
    });
  }

  late String akademisyenL ;
  late String turL;


  ekleDers() async{
    var yeni = DersModel(ad: adController.text, akademisyen: akademisyenL , alanlar: alanController.text, id: "id", sinif: sinifController.text, tur: turL);
    await FirebaseFirestore.instance.collection("dersler").add(yeni.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Ders Ekleme')),


     body: Center(
       child: Column(children: [
        SizedBox(height: 50,),
        Text('Ders Adı',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: adController,
           ),
         ),
         Text('Sınıf',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: sinifController,
           ),
         ),
         Text('Dersi Alanlar',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: alanController,
           ),
         ),
        Text('Ders Türü',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: turler.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
              setState(() {
                turL = turler[index].ad;
              });
            },
            title: Text(turler[index].ad),
          );
         })
         ,),
         Text('Ders Akademisyen',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: akalar.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
              setState(() {
                akademisyenL = akalar[index].ad;
              });
            },
            title: Text(akalar[index].ad),
          );
         })
         ,),
     
         ElevatedButton(onPressed: (){
     
          print(adController.text);
          ekleDers();
          
         }, child: Text('Dersi Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
    
     
         
       ],),
     )
    );
  }
}