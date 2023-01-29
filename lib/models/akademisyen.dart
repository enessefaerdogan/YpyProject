// To parse this JSON data, do
//
//     final AkademisyenModel = AkademisyenModelFromJson(jsonString);

import 'dart:convert';

AkademisyenModel AkademisyenModelFromJson(String str) => AkademisyenModel.fromJson(json.decode(str));

String AkademisyenModelToJson(AkademisyenModel data) => json.encode(data.toJson());

class AkademisyenModel {
    AkademisyenModel({
        required this.ad,
        required this.akaId,
        required this.sifre,
    });

    String ad;
    String akaId;
    String sifre;

    factory AkademisyenModel.fromJson(Map<String, dynamic> json) => AkademisyenModel(
        ad: json["ad"],
        akaId: json["aka_id"],
        sifre: json["sifre"],
    );

    Map<String, dynamic> toJson() => {
        "ad": ad,
        "aka_id": akaId,
        "sifre": sifre,
    };
}
