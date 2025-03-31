import 'package:json_annotation/json_annotation.dart';

class JsonAlwaysString extends JsonConverter<String, dynamic> {
  const JsonAlwaysString();

  @override
  String fromJson(json) {
    if (json is String) return json;
    return json.toString();
  }

  @override
  dynamic toJson(object) => object;
}
