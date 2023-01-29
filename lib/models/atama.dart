// To parse this JSON data, do
//
//     final atamaModel = atamaModelFromJson(jsonString);

import 'dart:convert';

AtamaModel atamaModelFromJson(String str) => AtamaModel.fromJson(json.decode(str));

String atamaModelToJson(AtamaModel data) => json.encode(data.toJson());

class AtamaModel {
    AtamaModel({
        required this.akademisyen,
        required this.baslama,
        required this.bitis,
        required this.ders,
        required this.derslik,
        required this.gun,
        required this.id,
        required this.sinif,
        required this.sube,
    });

    String akademisyen;
    String baslama;
    String bitis;
    String ders;
    String derslik;
    String gun;
    String id;
    String sinif;
    String sube;

    factory AtamaModel.fromJson(Map<String, dynamic> json) => AtamaModel(
        akademisyen: json["akademisyen"],
        baslama: json["baslama"],
        bitis: json["bitis"],
        ders: json["ders"],
        derslik: json["derslik"],
        gun: json["gun"],
        id: json["id"],
        sinif: json["sinif"],
        sube: json["sube"],
    );

    Map<String, dynamic> toJson() => {
        "akademisyen": akademisyen,
        "baslama": baslama,
        "bitis": bitis,
        "ders": ders,
        "derslik": derslik,
        "gun": gun,
        "id": id,
        "sinif": sinif,
        "sube": sube,
    };
}
