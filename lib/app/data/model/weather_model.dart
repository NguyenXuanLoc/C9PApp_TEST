// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(dynamic str) =>
    WeatherModel.fromJson(str);

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.dt,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  int? dt;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        dt: json["dt"],
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "base": base,
        "main": main!.toJson(),
        "visibility": visibility,
        "dt": dt,
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
/*    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,*/
  });

  dynamic temp;
  dynamic? feelsLike;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"],
        feelsLike: json["feels_like"],
/*        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],*/
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
/*        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,*/
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
