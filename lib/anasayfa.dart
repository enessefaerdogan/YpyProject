
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_deneme/atama.dart';
import 'package:flutter_deneme/ders.dart';
import 'package:flutter_deneme/models/atama.dart';
import 'package:flutter_deneme/models/ders.dart';
import 'package:flutter_deneme/models/saat.dart';
import 'package:flutter_deneme/saatler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'akademisyen.dart';
import 'derslik.dart';
class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<SaatModel> dersholder = [];
  List<SaatModel> sortholder = [
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
    SaatModel(ad: "ad", baslama: "baslama", bitis: "bitis", id: "id"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSaat();
    FirebaseFirestore.instance.collection("saatler").
    snapshots().listen((records) { 
      mapSaat(records);
    });


    fetchDers();
    FirebaseFirestore.instance.collection("dersler").
    snapshots().listen((records) { 
      mapDers(records);
    });


    fetchAtama();
    FirebaseFirestore.instance.collection("atama").
    snapshots().listen((records) { 
      mapAtama(records);
    });
  }
 fetchSaat()async{
    var records = await FirebaseFirestore.instance.collection("saatler").get();
    mapSaat(records);
  }
  mapSaat(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
   SaatModel(ad: item["ad"], baslama: item['baslama'], bitis: item['bitis'], id: item.id)).toList();
    setState(() {
      dersholder = list;
    });
  }


  // fethcders
    List<DersModel> derslerim = [];

   fetchDers()async{
    var records = await FirebaseFirestore.instance.collection("dersler").get();
    mapDers(records);
  }
  mapDers(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
DersModel(ad: item["ad"], akademisyen: item["akademisyen"], alanlar: item["alanlar"], id: item.id, sinif: item["sinif"], tur: item["tur"])).toList();
    setState(() {
      derslerim = list;
    });
  }


  // fetchAtama
    List<AtamaModel> atamalar = [];

   fetchAtama()async{
    var records = await FirebaseFirestore.instance.collection("atama").get();
    mapDers(records);
  }
  mapAtama(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
AtamaModel(akademisyen: item["akademisyen"], baslama: item["baslama"],
 bitis: item["bitis"], ders: item["ders"], derslik: item["derslik"], gun: item["gun"], 
 id: item.id, sinif: item["sinif"], sube: item["sube"])).toList();
    setState(() {
      atamalar = list;
    });
  }


  List<DersModel> realDersler = [];
  List<String> count = [];
  /*filterDers(){
     count = [];
     realDersler = [];


    
   for(int i=0;i<derslerim.length;i++){
     int index = 0;
    for(int k=0;k<atamalar.length;k++){
      if(derslerim[i].ad == atamalar[i].ders){
        print("EŞLEŞTİİİİİİİİİİİİİİİ");
        index++;
        print("PRİNTOSSS"+index.toString());
      }
   
      
    }print("İNDEXXXXXXXXXXXXXXXXXXXXXXXXXXX"+index.toString());
    // burası düzeltilcek
     //count.add(index.toString());

     if(index<=1){
      //print(derslerim[i].ad+"$index tane atanmıştır");
      realDersler.add(derslerim[i]);
     }
    

   }
  }*/



  
  
 /* sortDatas(){
    for(int i=0;i<dersholder.length;i++){
      
      if(dersholder[i].ad=='Ders1'){
        setState(() {
                  sortholder[0] = dersholder[i];

        });
        
      }
      else if(dersholder[i].ad=='Ders2'){
 setState(() {
                  sortholder[1] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders3'){
 setState(() {
                  sortholder[2] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders4'){
 setState(() {
                  sortholder[3] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders5'){
 setState(() {
                  sortholder[4] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders6'){
 setState(() {
                  sortholder[5] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders7'){
 setState(() {
                  sortholder[6] = dersholder[i];

        });      }
       else if(dersholder[i].ad=='Ders8'){
 setState(() {
                  sortholder[7] = dersholder[i];

        });      }
      
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(centerTitle: true,title: Text('Anasayfa')),

    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
  
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: ElevatedButton(onPressed: (){
              // akademisyen sayfasına gidiş
              Get.to(Akademisyen());
            }, child: Text('Akademisyen Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        ],
      ),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
             child: ElevatedButton(onPressed: (){
              // akademisyen sayfasına gidiş
              Get.to(Dersekle());
                 }, child: Text('Ders Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
           ),
         ],
       ),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
             child: ElevatedButton(onPressed: (){
              // akademisyen sayfasına gidiş
              Get.to(DerslikEkle());
                 }, child: Text('Derslik Ekle',style: TextStyle(fontWeight: FontWeight.bold),),),
           ),
         ],
       ),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
             child: ElevatedButton(onPressed: (){
              //sortDatas();
              // akademisyen sayfasına gidiş
             // Get.to(Saatler(dersholder));
             Get.to(SaatEkle(sortholder));
                 }, child: Text('Ders Saatleri',style: TextStyle(fontWeight: FontWeight.bold),),),
           ),
         ],
       ),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
             child: ElevatedButton(onPressed: (){
              //sortDatas();
              // akademisyen sayfasına gidiş
             // Get.to(Saatler(dersholder));
             //filterDers();
             Get.to(DersAtama(derslerim,atamalar));
                 }, child: Text('Ders Atama',style: TextStyle(fontWeight: FontWeight.bold),),),
           ),
         ],
       ),

     
     
     ],)
    );
  }
}