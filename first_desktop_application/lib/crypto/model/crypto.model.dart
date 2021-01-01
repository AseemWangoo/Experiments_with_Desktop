// To parse this JSON data, do
//
//     final cryptoModel = cryptoModelFromJson(jsonString);

import 'dart:convert';

CryptoModel cryptoModelFromJson(String str) =>
    CryptoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String cryptoModelToJson(CryptoModel data) => json.encode(data.toJson());

class CryptoModel {
  CryptoModel({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  Time time;
  String disclaimer;
  String chartName;
  Bpi bpi;

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        time: Time.fromJson(json["time"] as Map<String, dynamic>),
        disclaimer: json["disclaimer"] as String,
        chartName: json["chartName"] as String,
        bpi: Bpi.fromJson(json["bpi"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "time": time.toJson(),
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi.toJson(),
      };
}

class Bpi {
  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  Eur usd;
  Eur gbp;
  Eur eur;

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: Eur.fromJson(json["USD"] as Map<String, dynamic>),
        gbp: Eur.fromJson(json["GBP"] as Map<String, dynamic>),
        eur: Eur.fromJson(json["EUR"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "USD": usd.toJson(),
        "GBP": gbp.toJson(),
        "EUR": eur.toJson(),
      };
}

class Eur {
  Eur({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  String code;
  String symbol;
  String rate;
  String description;
  double rateFloat;

  factory Eur.fromJson(Map<String, dynamic> json) => Eur(
        code: json["code"] as String,
        symbol: json["symbol"] as String,
        rate: json["rate"] as String,
        description: json["description"] as String,
        rateFloat: json["rate_float"].toDouble() as double,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "description": description,
        "rate_float": rateFloat,
      };
}

class Time {
  Time({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  String updated;
  DateTime updatedIso;
  String updateduk;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"] as String,
        updatedIso: DateTime.parse(json["updatedISO"] as String),
        updateduk: json["updateduk"] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "updated": updated,
        "updatedISO": updatedIso.toIso8601String(),
        "updateduk": updateduk,
      };
}
