// To parse this JSON data, do
//
//     final saatModel = saatModelFromJson(jsonString);

import 'dart:convert';

SaatModel saatModelFromJson(String str) => SaatModel.fromJson(json.decode(str));

String saatModelToJson(SaatModel data) => json.encode(data.toJson());

class SaatModel {
    SaatModel({
        required this.ad,
        required this.baslama,
        required this.bitis,
        required this.id,
    });

    String ad;
    String baslama;
    String bitis;
    String id;

    factory SaatModel.fromJson(Map<String, dynamic> json) => SaatModel(
        ad: json["ad"],
        baslama: json["baslama"],
        bitis: json["bitis"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "ad": ad,
        "baslama": baslama,
        "bitis": bitis,
        "id": id,
    };
}
