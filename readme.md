### fullter utility project setup guide

This is a Flutter utility package designed to provide common utility classes for use in different projects.

This project was created with flutter 3.27 with following command:

```
flutter create --template=package flutter_util
```

#### folder structure

this project follows common flutter package development use case

```
flutter_util/
├── lib/
│   ├── src/
│   │   ├── some_utility.dart
│   │   └── another_utility.dart
│   └── flutter_util.dart
├── example/
│   ├── lib/
│   │   └── main.dart
├── test/
│   ├── json_schema_test.dart
│   └── another_utility_test.dart
├── pubspec.yaml
└── README.md
```

**lib**: Contains the main code for the package.
**example**: Contains an example Flutter application demonstrating how to use the package.
**example/lib**: Contains the main code for the example application.
**test**: Contains unit tests for the package.

#### An example folder that contains Fultter example application

The example project was created by running a Flutter create command to create a mobile-only project inside the root folder of this utility project

```
flutter create --platforms=android,ios,web example
```

#### assign the example project to use the fullter util library

Inside the example project, the following relative path is added in the `pubspec.yaml` file to reference classes in the utility project:

```
  flutter_util:
    path: ../
```

<br/><br/>

### JsonValidator

This JsonValidator utility in this library offer a quick way to validate json object with json schema
[refer to the json-shcema org for draft info](https://json-schema.org/)

#### example code

```dart
//first load the schema json file in
await JsonValidator().loadSchemas(['assets/schema/json_schema.json']);
//validate object to check email and password are valid
Map validateRes = JsonValidator().validate('emailPassWord', {'email': 'aaa@bbb.com', 'password': 'abcd1234'});
```

#### how the setting are stored in json file

the setting file stores different templates to validate object inupt, stored as follow format:

```json
{
   //template for the email + password object validation
   "emailPassWord": {
      //email property to check in given object
      "email": {
         //if error occour, the code to display
         "code": "emailInvalid",
         //is this field required in the given object
         "required": true,
         //the json schema used to check this field
         "schema": {
            "type": "string",
            "pattern": "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
         }
      },
      //password property to check in given object
      "password": {
         //if error occour, the code to display
         "code": "passwordInvalid",
         //is this field required in the given object
         "required": true,
         //the json schema used to check this field
         "schema": {
            "type": "string",
            "minLength": 8,
            "maxLength": 20
         }
      }
   },
   //other tempates for other object validation ...
   "objectCheckSetting": {
      "input": {
         "code": "error code to display",
         "required": true,
         "schema": {
            "type": "string",
            "description": "set custom schema..."
         }
      }
   }
}
```

##### the validation result object format

```json
// when a error occur
{
   //allValid is false when any error occur
   "allValid": false,
   //the errors object stores check result from each object property
   "errors": {
      //email field is valid, code is null and valid is true
      "email": {
         "code": null,
         "valid": true
      },
      //password field is invalid
      "password": {
         "code": "passwordInvalid",
         "valid": false
      }
   }
}
```

##### the return format for flutter widgets

The returned result object contains the check result for every property in the checked object. We can use the code value directly to toggle the error message on and off. Check the `lib/widgets/signin_box.dart` file for the SignInBox class and test it in the example project to see how it is used.
