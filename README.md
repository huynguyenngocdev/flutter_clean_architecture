# Flutter Clean Architecture

A Flutter codebase follow clean architecture. 

```
    - Flutter v3.x.x
    - Clean Architecture
    - Presentation use Bloc
```
## Author and Contact:
- Nguyen Ngoc Huy
- Email:[huynguyenngoc.dev@gmail.com](huynguyenngoc.dev@gmail.com)&gt;

## Technical architecture components
- Clean Architecture 
- Dart rule analyze: flutter_lints
- State management: flutter_bloc
- Dependency injection: get_it 
- Network: Dio &  Retrofit

## Run App
```
    flutter clean
    flutter pub get
    flutter pub run build_runner watch
    (or flutter pub run build_runner build --delete-conflicting-outputs)
    
    flutter run
```

## Build Release
- Android:
```
    flutter build apk 
```
- iOS:
```
    flutter build ios
```

## Project struct
- We use `BLOC` pattern and `Clean Architechture`
- `FLUTTER BLOC` -> https://pub.dev/packages/flutter_bloc
(PRESENT UI Layer > Business Logic (BLOC or Change notifier) -> REPOSITORY -> DATABASE or SERVICE -> ENTITIES)
- Feel free to use `ChangeNotifier` in any simple usecase.
- Please push share data model class in `entities` package
- App features are located in `modules` package. One feature per sub-module package (please see the `template`)

### Dependency Injection
- We use get_it package for Dependency Injection -> https://pub.dev/packages/get_it
- With help of injectable to generate the DI code https://pub.dev/packages/injectable
or https://blog.usejournal.com/flutter-di-a-true-love-story-1e5a5ae2ba2d


### Networking layer
- We use retrofit.dart as a `dio` client generator using `source_gen` and inspired by Chopper and Retrofit.
  -> https://pub.dev/packages/retrofit
  -> https://pub.dev/packages/dio
  -Too lazy to repeat write network layer ? We could try to do it for us retrofit-generator https://pub.dev/packages/retrofit_generator
