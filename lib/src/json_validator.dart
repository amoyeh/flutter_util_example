import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_schema/json_schema.dart';
import 'dart:convert';

class JsonValidator {
  JsonValidator._privateConstructor();
  static final JsonValidator _instance = JsonValidator._privateConstructor();
  // Factory constructor to return the same instance
  factory JsonValidator() {
    return _instance;
  }
  final Map<String, dynamic> _schemas = {};

  Future<void> loadSchemas(List<String> filePaths) async {
    for (var path in filePaths) {
      final String jsonData = await rootBundle.loadString(path);
      final Map<String, dynamic> data = jsonDecode(jsonData);
      data.forEach((key, value) {
        // note: dart jsonDecode already replaced object with same key with the last one
        _schemas[key] = value;
      });
    }
  }

  Map<String, dynamic> validate(String schemaName, dynamic inputData) {
    if (!_schemas.containsKey(schemaName)) {
      throw Exception('schemaName $schemaName not found');
    }
    var useRoles = _schemas[schemaName];
    Map<String, dynamic> errRes = {};
    bool hasError = false;
    for (var key in useRoles.keys) {
      dynamic value = useRoles[key];
      String code = value['code'];
      dynamic schema = value['schema'];
      bool required = false;
      if (value.containsKey('required')) required = value['required'];
      if (inputData.containsKey(key) == false && required) {
        hasError = true;
        errRes[key] = {'code': code, 'valid': false};
      } else {
        var validator = Validator(JsonSchema.create(schema));
        var results = validator.validate(inputData[key]);
        if (!results.isValid) {
          hasError = true;
          errRes[key] = {'code': code, 'valid': false};
        } else {
          //when result is valid, set empty error string, so that UI can display without error
          errRes[key] = {'code': null, 'valid': true};
        }
      }
    }
    return {'allValid': (hasError == false), 'errors': errRes};
  }
}
