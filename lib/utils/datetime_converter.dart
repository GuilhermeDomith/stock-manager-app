
import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.contains('.')){
      //Remove last digit from string date
      json = json.substring(0, json.length -1);
    }

    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime dateTime) {
    String date;
    if(dateTime != null)
      date = dateTime.toIso8601String();
    return date;
  }

}