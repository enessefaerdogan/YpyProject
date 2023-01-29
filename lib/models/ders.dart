// dersmodel
// To parse this JSON data, do
//
//     final dersModel = dersModelFromJson(jsonString);

import 'dart:convert';

DersModel dersModelFromJson(String str) => DersModel.fromJson(json.decode(str));

String dersModelToJson(DersModel data) => json.encode(data.toJson());

class DersModel {
    DersModel({
        required this.ad,
        required this.akademisyen,
        required this.alanlar,
        required this.id,
        required this.sinif,
        required this.tur,
    });

    String ad;
    String akademisyen;
    String alanlar;
    String id;
    String sinif;
    String tur;

    factory DersModel.fromJson(Map<String, dynamic> json) => DersModel(
        ad: json["ad"],
        akademisyen: json["akademisyen"],
        alanlar: json["alanlar"],
        id: json["id"],
        sinif: json["sinif"],
        tur: json["tur"],
    );

    Map<String, dynamic> toJson() => {
        "ad": ad,
        "akademisyen": akademisyen,
        "alanlar": alanlar,
        "id": id,
        "sinif": sinif,
        "tur": tur,
    };
}
