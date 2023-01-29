// To parse this JSON data, do
//
//     final derslikModel = derslikModelFromJson(jsonString);

import 'dart:convert';

DerslikModel derslikModelFromJson(String str) => DerslikModel.fromJson(json.decode(str));

String derslikModelToJson(DerslikModel data) => json.encode(data.toJson());

class DerslikModel {
    DerslikModel({
        required this.ad,
        required this.id,
        required this.kapasite,
        required this.kategori,
    });

    String ad;
    String id;
    String kapasite;
    String kategori;

    factory DerslikModel.fromJson(Map<String, dynamic> json) => DerslikModel(
        ad: json["ad"],
        id: json["id"],
        kapasite: json["kapasite"],
        kategori: json["kategori"],
    );

    Map<String, dynamic> toJson() => {
        "ad": ad,
        "id": id,
        "kapasite": kapasite,
        "kategori": kategori,
    };
}
