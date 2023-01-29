
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_deneme/models/akademisyen.dart';
import 'package:flutter_deneme/models/ders.dart';
import 'package:flutter_deneme/models/derslik.dart';
import 'package:flutter_deneme/models/tur.dart';
import 'package:get/get_core/src/get_main.dart';
class DerslikEkle extends StatefulWidget {
  const DerslikEkle({super.key});

  @override
  State<DerslikEkle> createState() => _DerslikEkleState();
}

class _DerslikEkleState extends State<DerslikEkle> {
  TextEditingController adController = TextEditingController();
  TextEditingController kapasiteController = TextEditingController();
  
    List<TurModel> turler = [];
  
  // data ekleme veritabanına 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fetchTur();
    FirebaseFirestore.instance.collection("tur").
    snapshots(

    ).listen((records) { 
      mapTur(records);
    });

  }

  //fetch turler
   fetchTur()async{
    var records = await FirebaseFirestore.instance.collection("tur").get();
    mapTur(records);
  }
  mapTur(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
 TurModel(ad: item['ad'], id: item.id)).toList();
    setState(() {
      turler = list;
    });
  }

  late String turL;


  ekleDerslik() async{
    var yeni = DerslikModel(ad: adController.text, id: "id", kapasite: kapasiteController.text, kategori: turL);
    await FirebaseFirestore.instance.collection("derslik").add(yeni.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Derslik Ekle')),


     body: Center(
       child: Column(children: [
        SizedBox(height: 50,),
        Text('Derslik Adı',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: adController,
           ),
         ),
         Text('Derslik Kapasite',style: TextStyle(fontWeight: FontWeight.bold),),
         Container(
          width: 200,
          height: 70,
           child: TextField(
            controller: kapasiteController,
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
     
         ElevatedButton(onPressed: (){
     
          print(adController.text);
          ekleDerslik();
          
         }, child: Text('Derslik Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
    
     
         
       ],),
     )
    );
  }
}