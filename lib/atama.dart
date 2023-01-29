
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_deneme/models/akademisyen.dart';
import 'package:flutter_deneme/models/atama.dart';
import 'package:flutter_deneme/models/ders.dart';
import 'package:flutter_deneme/models/derslik.dart';
import 'package:flutter_deneme/models/saat.dart';
import 'package:flutter_deneme/models/tur.dart';
import 'package:get/get_core/src/get_main.dart';
class DersAtama extends StatefulWidget {
List<DersModel> dersler;
List<AtamaModel> atamalar;

DersAtama(this.dersler,this.atamalar);
  @override
  State<DersAtama> createState() => _DersAtamaState(dersler,atamalar);
}

class _DersAtamaState extends State<DersAtama> {
  List<DersModel> dersler;
  List<AtamaModel> atamalar;

  _DersAtamaState(this.dersler,this.atamalar);



  TextEditingController adController = TextEditingController();
  TextEditingController sinifController = TextEditingController();
  TextEditingController alanController = TextEditingController();
  
  
  List<TurModel> turler = [];
  
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ELAMANLARRRRRRRRRRRRRRR"+dersler.length.toString());
    
    
    fetchTur();
    FirebaseFirestore.instance.collection("tur").
    snapshots(

    ).listen((records) { 
      mapTur(records);
    });

    filterDers();
    pageindex = 0;
  
    
    fetchAka();
    FirebaseFirestore.instance.collection("akademisyen").
    snapshots(

    ).listen((records) { 
      mapAka(records);
    });

  
    
    fetchDeslik();
    FirebaseFirestore.instance.collection("derslik").
    snapshots(

    ).listen((records) { 
      mapDerslik(records);
    });

    

    fetchSaat();
     FirebaseFirestore.instance.collection("saat").
    snapshots(

    ).listen((records) { 
      mapSaat(records);
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
  
  //fetch akademisyen
   List<AkademisyenModel> akalar = [];
   fetchAka()async{
    var records = await FirebaseFirestore.instance.collection("akademisyen").get();
    mapAka(records);
  }
  mapAka(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
    setState(() {
      akalar = list;
    });
  }
  

  //derslikler fetch
   List<DerslikModel> derslikler = [];
   fetchDeslik()async{
    var records = await FirebaseFirestore.instance.collection("derslik").get();
    mapDerslik(records);
  }
  mapDerslik(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
 DerslikModel(ad: item["ad"], id: item.id, kapasite: item["kapasite"], kategori: item["kategori"])).toList();
    setState(() {
      derslikler = list;
    });
  }

  //saatler fetch
   List<SaatModel> saatler = [];
   fetchSaat()async{
    var records = await FirebaseFirestore.instance.collection("saat").get();
    mapDerslik(records);
  }
  mapSaat(QuerySnapshot<Map<String,dynamic>> recordlar){
   var list = recordlar.docs.map((item) =>
    //AkademisyenModel(ad: item["ad"], akaId: item.id, sifre: item["sifre"])).toList();
SaatModel(ad: item["ad"], baslama: item["baslama"], bitis: item["bitis"], id: item.id)).toList();
    setState(() {
      saatler = list;
    });
  }
  


  // filtreleme
  // burada ana filtreleme var eger 2 veya daha fazla kayıt varsa onu almayız
  List<DersModel> realDersler = [];
  List<String> count = [];
  filterDers(){
     count = [];
     realDersler = [];


    
   for(int i=0;i<dersler.length;i++){
     int index = 0;
    for(int k=0;k<atamalar.length;k++){
      if(dersler[i].ad == atamalar[i].ders){
        index++;
      }
      
    }print("İNDEXXXXXXXXXXXXXXXXXXXXXXXXXXX"+index.toString());
    // burası düzeltilcek
     //count.add(index.toString());

     if(index==1 || index==0){
      print(dersler[i].ad+"$index tane atanmıştır");
      realDersler.add(dersler[i]);
     }
    

   }
  }
  
  int pageindex=0;
  DersModel dersChosed = DersModel(ad: "", akademisyen: "akademisyen", alanlar: "alanlar", id: "id", sinif: "sinif", tur: "tur");
  List<String> subeY = ['A','B'];
  subeFilter(){
    subeY = ['A','B'];
  for(int i=0;i<atamalar.length;i++){
    if(dersChosed.ad == atamalar[i].ders){
      setState(() {
        print(subeY);
        if(atamalar[i].sube=='A'){
              subeY.remove('A');

        }
        else{
          subeY.remove('B');
        }

      });
    }
  }
  }

  // derslik filter
  List<DerslikModel> realDerslik  = [];
  derslikFilter(){
    realDerslik = [];
    for(int i=0;i<derslikler.length;i++){
      print("for içindeyim");
      print(dersChosed.alanlar);
      print(derslikler[i].kapasite);
      if((int.parse(dersChosed.alanlar) <= int.parse(derslikler[i].kapasite)) && dersChosed.tur == derslikler[i].kategori){
        print("ÇALIŞTIII");
        // eğer kapasite kurtarıyorsa ve tür aynıysa diyelim
        setState(() {
          realDerslik.add(derslikler[i]);
        });
      }
    }
  }

  String subeChosed = '';
  String derslikChosed = '';
  String akaChosed = '';

  List<String> gunler = ['Pazartesi','Salı','Çarşamba','Perşembe','Cuma'];
 
  // gun bazlı akademisyen ve derslik kontrol yapılacak ilerleye basınca 
  String gunChosed ='';
 /* 
 atamalar gun ve derslik bazlı kontrol edilir eşleşen kayıtlar tek tek listeye alınır veya orada denenir
 arada kalıp çakışıyorsa orda derslik müsait değildir , aynı şey akademisyen içinde geçerlidir*/
 bool derslikKontrol(String gunChosed,String baslangic,String bitis){
   List<AtamaModel> kesinsenAtamalar = [];
   for(int i=0;i<atamalar.length;i++){
    // baslangıc az bitiş aradaysa
    // baslangıc ve bitis aradaysa
    // baslangıc arada bitis buyukse
    if((atamalar[i].gun == gunChosed) && atamalar[i].derslik == derslikChosed){
      print("buneyla");
         kesinsenAtamalar.add(atamalar[i]);
    }
   }

   for(int i=0;i<kesinsenAtamalar.length;i++){
    if((double.parse(baslangic)<=double.parse(kesinsenAtamalar[i].baslama)) && double.parse(kesinsenAtamalar[i].baslama)<= double.parse(bitis) && double.parse(bitis)<=double.parse(kesinsenAtamalar[i].bitis)){

     print("Çakışma var derslik boş değil 1111111111");
     return true;
    }
    else if((double.parse(kesinsenAtamalar[i].baslama)<=double.parse(baslangic) && double.parse(baslangic)<=double.parse(kesinsenAtamalar[i].bitis)
     && double.parse(kesinsenAtamalar[i].baslama)<=double.parse(bitis) && double.parse(bitis)<=double.parse(kesinsenAtamalar[i].bitis))){
      return true;

    }
    else if(((double.parse(kesinsenAtamalar[i].baslama)<=double.parse(baslangic) && double.parse(baslangic)<=double.parse(kesinsenAtamalar[i].bitis))
     && double.parse(kesinsenAtamalar[i].bitis)<=double.parse(bitis))){
      return true;

    }


   }

return false;

  }

  String baslangicSaat = '';
  String bitisSaat =  '';


  // akademisyen Kontrol
  bool akaKontrol(String akademisyen,String baslama,String bitis){
    List<AtamaModel> akaAtama = [];
    /*
akademisyenin o gün o saatte işi varmı diye bakıcaz

    */
// atamalardan akademisyeni içerenleri çekicez
    for(int i=0;i<atamalar.length;i++){
     if(atamalar[i].akademisyen == akademisyen){
      setState(() {
        akaAtama.add(atamalar[i]);
      });
     }
    }

    // ortaklar
    for(int i=0;i<akaAtama.length;i++){


   if((double.parse(baslama)<=double.parse(akaAtama[i].baslama)) && double.parse(akaAtama[i].baslama)<= double.parse(bitis) && double.parse(bitis)<=double.parse(akaAtama[i].bitis)){

     print("Çakışma var derslik boş değil 1111111111");
     return true;
    }
    else if((double.parse(akaAtama[i].baslama)<=double.parse(baslama) && double.parse(baslama)<=double.parse(akaAtama[i].bitis)
     && double.parse(akaAtama[i].baslama)<=double.parse(bitis) && double.parse(bitis)<=double.parse(akaAtama[i].bitis))){
      return true;

    }
    else if(((double.parse(akaAtama[i].baslama)<=double.parse(baslama) && double.parse(baslama)<=double.parse(akaAtama[i].bitis))
     && double.parse(akaAtama[i].bitis)<=double.parse(bitis))){
      return true;

    }


   }

    return false;
  }



// atamaa ekleme
addAtama()async{

  var newAtama = AtamaModel(akademisyen: dersChosed.akademisyen, baslama: baslangicSaat, bitis: bitisSaat, 
  ders: dersChosed.ad, derslik: derslikChosed, gun: gunChosed, id: "id", sinif: dersChosed.sinif, sube: subeChosed);

  await FirebaseFirestore.instance.collection("atama").add(newAtama.toJson());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Atama Sayfası')),


     body: pageindex==0 ? Center(
       child: Column(children: [
        SizedBox(height: 50,),
        Text(dersChosed.ad.length >0 ? 'Atanmamış Dersler(${dersChosed.ad})' : 'Atanmamış Dersler( - )',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height:30),

        Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: realDersler.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
              setState(() {
                dersChosed = realDersler[index];
              });
            },
            title: Text(realDersler[index].ad),
            //subtitle: Text(count[index]),
          );
         })
         ,),
         SizedBox(height: 50,),
        // Text("Seçilen Ders : "+dersChosed.ad),
            //      SizedBox(height: 20,),

     
     
         
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: ElevatedButton(onPressed: (){
              setState(() {
                      pageindex = pageindex+1;

          });

          subeFilter();
          print("çalıştı");
              
            }, child: Text('İleri',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        ],
      ),
         
       ],),
     )
     
     
     :
     
     pageindex==1 ?
     
     Center(
       child: Column(children: [
        SizedBox(height: 50,),
        Text(subeChosed.length>0 ? 'Şube($subeChosed)' : 'Şube( - )',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height:30),
        
        Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: subeY.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
              setState(() {
                subeChosed = subeY[index];
              });
            
            },
            title: Text(subeY[index]),
            //subtitle: Text(count[index]),
          );
         })
         ,),
         SizedBox(height: 50,),
         //Text("Seçilen Şube : "+subeChosed),
          //        SizedBox(height: 20,),

     
     
         
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: ElevatedButton(onPressed: (){
              setState(() {
                      pageindex = pageindex+1;
                      print("pageindex(subeydi) : "+pageindex.toString());
                      derslikFilter();
                      print(realDerslik);

          });
              
            }, child: Text('İleri',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),

         /*  Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: ElevatedButton(onPressed: (){
              setState(() {
                      pageindex = pageindex-1;

          });
              
            }, child: Text('Geri',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),*/
        ],
      ),
         
       ],),
     )   : pageindex==2 ? Center(
       child: Column(children: [
        SizedBox(height: 20,),
        Text(derslikChosed.length>0 ? 'Derslik($derslikChosed)' :'Derslik( - )',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height:30),
        
        Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: realDerslik.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
            setState(() {
              derslikChosed = realDerslik[index].ad;
              
            });
            },
            title: Text(realDerslik[index].ad),
            //subtitle: Text(count[index]),
          );
         })
         ,),
         SizedBox(height: 30,),

     
     
         
   
      Text(gunChosed.length>0 ? 'Gün($gunChosed)': 'Gün( - )',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height:20),
        
        Container(
          width: double.infinity,
          height: 100,
          
          child: ListView.builder(
            itemCount: gunler.length,itemBuilder: (BuildContext context,index){
          return ListTile(
            onTap: (){
            setState(() {
              gunChosed = gunler[index];
              
            });
            },
            title: Text(gunler[index]),
            //subtitle: Text(count[index]),
          );
         })
         ,),
         // Ders Seçimi derd 1 ders 2 ws 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(baslangicSaat.length>0 ? 'Başlangıç($baslangicSaat)                           ': 'Başlangıç( - )',style: TextStyle(fontWeight: FontWeight.bold),),
              Text(bitisSaat.length>0 ? 'Bitiş($bitisSaat)': 'Bitiş( - )',style: TextStyle(fontWeight: FontWeight.bold),),

            ],
          ),
        SizedBox(height:20),
        
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.42,
              height: 160,
              
              child: ListView.builder(
                itemCount: saatler.length,itemBuilder: (BuildContext context,index){
              return ListTile(
                onTap: (){
                setState(() {
                  baslangicSaat = saatler[index].baslama;
                  
                });
                },
                title: Text(saatler[index].ad),
                subtitle: Text(saatler[index].baslama+"-"+saatler[index].bitis),
              );
             })
             ,),

             Container(
              width: MediaQuery.of(context).size.width*0.46,
              height: 160,
              
              child: ListView.builder(
                itemCount: saatler.length,itemBuilder: (BuildContext context,index){
              return ListTile(
                onTap: (){
                setState(() {
                  bitisSaat = saatler[index].bitis;
                  
                });
                },
                title: Text(saatler[index].ad),
                subtitle: Text(saatler[index].baslama+"-"+saatler[index].bitis),
              );
             })
             ,),
          ],
        ),
        SizedBox(height: 40,),


// en altta dursun bu
            Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 50,
            child: ElevatedButton(onPressed: (){
              setState(() {
                      //pageindex = pageindex+1; geçici olarak yoruma alındı
                      if(derslikKontrol(gunChosed, baslangicSaat, bitisSaat)){
                print("DERSLER ÇAKIŞITTTTTTTTTTTTTTTTTTTTTTTTTTTTIII");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Seçilen saatte derslik doludur',),backgroundColor: Colors.red,));
              }else{
                addAtama();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ders Başarıyla Atandı',),backgroundColor: Colors.green,));

              }
             /* if(akaKontrol(dersChosed.akademisyen, baslangicSaat, bitisSaat)){
                print("AKADEMİSYEN ÇAKIŞIYOR!!");
              }*/

          });
              
            }, child: Text('Atama Yap',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        ],
      ),
       ],),
     ): Text('Ders Atama Başarılı')
    );
  }
}