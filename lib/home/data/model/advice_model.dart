import 'dart:convert';

AdviceModel adviceModelFromJson(String str) => AdviceModel.fromJson(json.decode(str));

String AdviceModelToJson(AdviceModel data) => json.encode(data.toJson());

class AdviceModel {
  AdviceModel({
    required this.slip,
  });
  Slip? slip;

  factory AdviceModel.fromJson(Map<String, dynamic> json) => AdviceModel(
    slip: json['slip'] != null ? Slip.fromJson(json['slip']) : null,
  );

  Map<String, dynamic> toJson() => {
    "slip" : slip,
  };
}
class Slip {
  int? id;
  String? advice;


  Slip({this.id, this.advice});

  Slip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advice'] = advice;
    return data;
  }
}


