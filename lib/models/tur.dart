// To parse this JSON data, do
//
//     final turModel = turModelFromJson(jsonString);

import 'dart:convert';

TurModel turModelFromJson(String str) => TurModel.fromJson(json.decode(str));

String turModelToJson(TurModel data) => json.encode(data.toJson());

class TurModel {
    TurModel({
        required this.ad,
        required this.id,
    });

    String ad;
    String id;

    factory TurModel.fromJson(Map<String, dynamic> json) => TurModel(
        ad: json["ad"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "ad": ad,
        "id": id,
    };
}
