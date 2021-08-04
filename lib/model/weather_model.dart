class WeatherModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherModel(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});
  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Main {
  String? temp;
  String? feelsLike;
  String? tempMin;
  String? tempMax;
  String? pressure;
  String? humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toString();
    feelsLike = json['feels_like'].toString();
    tempMin = json['temp_min'].toString();
    tempMax = json['temp_max'].toString();
    pressure = json['pressure'].toString();
    humidity = json['humidity'].toString();
  }
}

class Wind {
  String? speed;
  String? deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toString();
    deg = json['deg'].toString();
  }
}

class Clouds {
  String? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'].toString();
  }
}

class Sys {
  String? type;
  String? id;
  String? country;
  String? sunrise;
  String? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    id = json['id'].toString();
    country = json['country'].toString();
    sunrise = json['sunrise'].toString();
    sunset = json['sunset'].toString();
  }
}
