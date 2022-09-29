// To parse this JSON data, do
//
//     final interestResponse = interestResponseFromJson(jsonString);

import 'dart:convert';

InterestResponse interestResponseFromJson(String str) =>
    InterestResponse.fromJson(json.decode(str));

String interestResponseToJson(InterestResponse data) =>
    json.encode(data.toJson());

class InterestResponse {
  InterestResponse({
    required this.codigo,
    required this.descripcion,
    required this.series,
    required this.seriesInfos,
  });

  int codigo;
  String descripcion;
  Series series;
  List<dynamic> seriesInfos;

  factory InterestResponse.fromJson(Map<String, dynamic> json) =>
      InterestResponse(
        codigo: json["Codigo"],
        descripcion: json["Descripcion"],
        series: Series.fromJson(json["Series"]),
        seriesInfos: List<dynamic>.from(json["SeriesInfos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Descripcion": descripcion,
        "Series": series.toJson(),
        "SeriesInfos": List<dynamic>.from(seriesInfos.map((x) => x)),
      };
}

class Series {
  Series({
    required this.descripEsp,
    required this.descripIng,
    required this.seriesId,
    required this.obs,
  });

  String descripEsp;
  String descripIng;
  String seriesId;
  List<Ob> obs;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        descripEsp: json["descripEsp"],
        descripIng: json["descripIng"],
        seriesId: json["seriesId"],
        obs: List<Ob>.from(json["Obs"].map((x) => Ob.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "descripEsp": descripEsp,
        "descripIng": descripIng,
        "seriesId": seriesId,
        "Obs": List<dynamic>.from(obs.map((x) => x.toJson())),
      };
}

class Ob {
  Ob({
    required this.indexDateString,
    required this.value,
    required this.statusCode,
  });

  String indexDateString;
  String value;
  String statusCode;

  factory Ob.fromJson(Map<String, dynamic> json) => Ob(
        indexDateString: json["indexDateString"],
        value: json["value"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "indexDateString": indexDateString,
        "value": value,
        "statusCode": statusCode,
      };
}
