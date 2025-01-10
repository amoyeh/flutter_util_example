import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util/flutter_util.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Load any necessary assets or perform setup tasks here
      
  });

  test('validate emailPassword input with wrong password', () {
    Map validateRes = JsonValidator().validate('emailPassWord', {'email': 'aaa@bbb.com', 'password': 'abc'});
    //password error result
    expect(validateRes['allValid'], false);
    expect(validateRes['errors']['password'], {'code': 'passwordInvalid', 'valid': false});
  });

  test('validate emailPassword input with corret input', () {
    Map validateRes = JsonValidator().validate('emailPassWord', {'email': 'aaa@bbb.com', 'password': 'abcd1234'});
    expect(validateRes['allValid'], true);
  });

  test('signUpForm test', () {
    Map form1 = {'email': 'abc@123.com', 'password': 'abcd1234', 'gender': 'm'};

    // validate first form
    dynamic validateRes = JsonValidator().validate('signUpForm', form1);
    expect(validateRes['allValid'], false);
    expect(validateRes['errors']['over18'], {'code': 'over18Invalid', 'valid': false});
    expect(validateRes['errors']['age'], {'code': 'ageInvalid', 'valid': false});
    expect(validateRes['errors']['birthDate'], {'code': 'birthDateInvalid', 'valid': false});

    // validate 2nd form all valid
    Map form2 = {'email': 'abc@123.com', 'password': 'abcd1234', 'gender': 'm', 'over18': true, 'age': 20, 'birthDate': '11/11/2024'};
    dynamic validateRes2 = JsonValidator().validate('signUpForm', form2);
    expect(validateRes2['allValid'], true);

    // validate 3rd form with missing required field
    Map form3 = {'email': 'abc@123.com', 'password': 'abcd1234'};
    dynamic validateRes3 = JsonValidator().validate('signUpForm', form3);
    expect(validateRes3['allValid'], false);
    debugPrint('validateRes3:\n$validateRes3');
  });
}
