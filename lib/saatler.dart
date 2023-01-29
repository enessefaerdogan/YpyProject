import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deneme/models/akademisyen.dart';
import 'package:flutter_deneme/models/saat.dart';


class SaatEkle extends StatefulWidget {
  List<SaatModel> derslerim;
  SaatEkle(this.derslerim);
  @override
  State<SaatEkle> createState() => _SaatEkleState(derslerim);
}

class _SaatEkleState extends State<SaatEkle> {
  
  List<SaatModel> derslerim;
  _SaatEkleState(this.derslerim);



  List<SaatModel> saatler = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
     fetchAka2();
    FirebaseFirestore.instance.collection("saat").
    snapshots(

    ).listen((records) { 
      mapAka2(records);
    });
  }
 

fetchAka2()async{
    var records = await FirebaseFirestore.instance.collection("saat").get();
    mapAka2(records);
  }
  mapAka2(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    SaatModel(ad: item["ad"], baslama: item["baslama"], bitis: item["bitis"], id: item.id)).toList();
    setState(() {
      saatler = list;
    });
  }

  updateData1(String adY,String idY,String bitisY)async{
    var yeni = SaatModel(ad:adY , baslama: "${basController.text}.${bas2Controller.text}", bitis: bitisY, id: idY);
    await FirebaseFirestore.instance.collection("saat").doc(idY).update(yeni.toJson());
  }

  updateData2(String adY,String idY,String baslamaY)async{
    var yeni = SaatModel(ad:adY , baslama:baslamaY, bitis:  "${bitController.text}.${bit2Controller.text}", id: idY);
    await FirebaseFirestore.instance.collection("saat").doc(idY).update(yeni.toJson());
  }
updateData3(String adY,String idY)async{
    var yeni = SaatModel(ad:adY , baslama:"${basController.text}.${bas2Controller.text}", bitis:  "${bitController.text}.${bit2Controller.text}", id: idY);
    await FirebaseFirestore.instance.collection("saat").doc(idY).update(yeni.toJson());
  }




  late String lbaslama1;
  late String lbaslama2;
  late String lbitis1;
  late String lbitis2;
  //late String lbaslama1;
  


TextEditingController basController = TextEditingController();
TextEditingController bas2Controller = TextEditingController();
TextEditingController bitController = TextEditingController();
TextEditingController bit2Controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saat Düzenleme')),
   
    body: Column(
      children: [
        SizedBox(height: 30,),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Text('Dersler',style: TextStyle(fontWeight: FontWeight.bold),),
        ],),

        Container(
          width: double.infinity,
          height: 600,
          child: saatler.length>0 ? 
           ListView.builder(

            itemCount: derslerim.length,// önemli

            itemBuilder: (BuildContext context,index){

            return ListTile(
              //title: Text('${saatler[index].ad}'),
             // subtitle: Text('${saatler[index].sifre} - ${saatler[index].sifre}'),
             title: Text('${saatler[index].ad}'),
             subtitle: Text('${saatler[index].baslama} - ${saatler[index].bitis}'),
             onTap: (){
              showDialog(
  context: context,
  builder: (context) => Container(
    width: 200,
    height: 200,
    child: AlertDialog(
      title: Center(child: Text('Saat Bilgilerini Düzenle')),
      content: Column(
        children: [
  
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Başlama Saati"),
                Text('${saatler[index].baslama}'),
                
              ],
            ),

          ],
        ),
         SizedBox(height: 25,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(width: 50,child: TextField(controller: basController,decoration: InputDecoration(label: Text('Saat')),)),
            Container(width: 50,child: TextField(controller: bas2Controller,decoration: InputDecoration(label: Text('Dakika')),)),
          ],
        ),
        SizedBox(height: 40,),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Bitiş Saati"),
                Text('${saatler[index].bitis}'),
                
              ],
            ),

          ],
        ),
                SizedBox(height: 25,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(width: 50,child: TextField(controller: bitController,decoration: InputDecoration(label: Text('Saat')),)),
            Container(width: 50,child: TextField(controller: bit2Controller,decoration: InputDecoration(label: Text('Dakika')),)),
          ],
        ),
  
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // data update edilsin
              if((basController.text.length>0 && bas2Controller.text.length>0) && bitController.text.length==0 && bit2Controller.text.length==0){
                 updateData1(saatler[index].ad, saatler[index].id,saatler[index].bitis);
              }
              else if((bitController.text.length>0 && bit2Controller.text.length>0) && basController.text.length==0 && bas2Controller.text.length==0){
                 updateData2(saatler[index].ad, saatler[index].id,saatler[index].baslama);

              }
              else if((bitController.text.length>0 && bit2Controller.text.length>0) && basController.text.length>0 && bas2Controller.text.length>0){
                 updateData3(saatler[index].ad, saatler[index].id);

              }
              


              basController.text = '';
              bas2Controller.text = '';
              bitController.text = '';
              bit2Controller.text = '';
            },
            child: Text('Kaydet'))
      ],
    ),
  ),
);
             },
            );
          }) : CircularProgressIndicator(),
        )
   
    
      ])
    );
  }
}