// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

List<StockModel> stockModelFromJson(String str) => List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

String stockModelToJson(List<StockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockModel {
  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criterion>? criteria;

  StockModel({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criteria,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    id: json["id"],
    name: json["name"],
    tag: json["tag"],
    color: json["color"],
    criteria: json["criteria"] == null ? [] : List<Criterion>.from(json["criteria"]!.map((x) => Criterion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tag": tag,
    "color": color,
    "criteria": criteria == null ? [] : List<dynamic>.from(criteria!.map((x) => x.toJson())),
  };
}

class Criterion {
  String? type;
  String? text;
  Map<String, dynamic>? variable;

  Criterion({
    this.type,
    this.text,
    this.variable,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) => Criterion(
    type: json["type"],
    text: json["text"],
    variable: json["variable"] == null ? null : json["variable"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text,
    "variable": variable,
  };
}

/*class Variable {
  The1? the1;
  The2? the2;
  The2? the3;
  The1? the4;

  Variable({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
    the1: json["\u00241"] == null ? null : The1.fromJson(json["\u00241"]),
    the2: json["\u00242"] == null ? null : The2.fromJson(json["\u00242"]),
    the3: json["\u00243"] == null ? null : The2.fromJson(json["\u00243"]),
    the4: json["\u00244"] == null ? null : The1.fromJson(json["\u00244"]),
  );

  Map<String, dynamic> toJson() => {
    "\u00241": the1?.toJson(),
    "\u00242": the2?.toJson(),
    "\u00243": the3?.toJson(),
    "\u00244": the4?.toJson(),
  };
}

class The1 {
  String? type;
  List<int>? values;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  The1({
    this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  factory The1.fromJson(Map<String, dynamic> json) => The1(
    type: json["type"],
    values: json["values"] == null ? [] : List<int>.from(json["values"]!.map((x) => x)),
    studyType: json["study_type"],
    parameterName: json["parameter_name"],
    minValue: json["min_value"],
    maxValue: json["max_value"],
    defaultValue: json["default_value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
    "study_type": studyType,
    "parameter_name": parameterName,
    "min_value": minValue,
    "max_value": maxValue,
    "default_value": defaultValue,
  };
}

class The2 {
  String? type;
  List<double>? values;

  The2({
    this.type,
    this.values,
  });

  factory The2.fromJson(Map<String, dynamic> json) => The2(
    type: json["type"],
    values: json["values"] == null ? [] : List<double>.from(json["values"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
  };
}*/
