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

#### create example folder for Fultter application

after this package project is created, inside this project run following command to create the example application project

```
flutter create --platforms=android,ios,web example
```

#### assign the example project to use the fullter util library

go to the pubspec.yaml inside example project, add library reference in dependencies setting

```
  flutter_util:
    path: ../
```
