# Flutter Clean Architecture

A Flutter codebase follows the clean architecture and makes it scalable with a modularization approach.  

```
    - Flutter v3.x.x
    - Clean Architecture
    - Presentation use Bloc
```

## Contact:
- Nguyen Ngoc Huy &lt;[huynguyenngoc.dev@gmail.com](huynguyenngoc.dev@gmail.com)&gt;

## Technical architecture components
- Clean Architecture 
- Dart rule analyze: flutter_lints
- State management: flutter_bloc
- Dependency injection: get_it & injectable_generator
- Network: Dio &  Retrofit
- Manage fonts and images: flutter_gen

## Environment
**Framework**
- Dart: '>=2.18.0 <3.0.0'
- Flutter: '>=3.0.0'

**iOS**
- iOS 12+

**Android**
- Android 7.0+
    - minSdkVersion 24
- targetSdkVersion 31

## Run App
`Please turn on your simulator or connect with your physical device before:`
- Set up to run:
```
    flutter clean
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
```
- Run with Flavor (dev | stag | prod):
```   
    flutter run --flavor development -t lib/main.dev.dart
    or flutter run --flavor staging -t lib/main.staging.dart
    or lutter run --flavor product -t lib/main.product.dart
   
```
- If using the another library not build with null-safety. Please run with argument `flutter run --no-sound-null-safety`

## Build Release
- Android:
```
    flutter build apk 
```
- iOS:
```
    flutter build ios
```

## General NOTE:
**Code style:**
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
**If added some assets/fonts/colors**
- Use [FlutterGen](https://github.com/FlutterGen/flutter_gen/)
**If added some models for api results**
- Use [Freezed](https://pub.dev/packages/freezed) or [Equatable](https://pub.dev/packages/equatable)
**Auto generate resource(___.g.dart/___.freezed.dart)**
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Project struct
- I use `BLOC` pattern and `MVVM` + `Clean Architechture`
- `FLUTTER BLOC` -> https://pub.dev/packages/flutter_bloc
(PRESENT UI Layer > Business Logic (BLOC or Change notifier) -> REPOSITORY -> DATABASE or SERVICE -> ENTITIES)
- Feel free to use `ChangeNotifier` in any simple usecase.
- Please push share data model class in `entities` package
- App features are located in `modules` package. One feature per sub-module package (please see the `template`)

### Dependency Injection
- I use get_it package for Dependency Injection -> https://pub.dev/packages/get_it
- With help of injectable to generate the DI code https://pub.dev/packages/injectable
or https://blog.usejournal.com/flutter-di-a-true-love-story-1e5a5ae2ba2d

### Networking layer
- I use dio_builder.dart as a `dio` client generator using `source_gen` and inspired by Chopper and Retrofit.
    - About `Retrofit`: https://pub.dev/packages/retrofit and https://mings.in/retrofit.dart/
    - About `dio`: https://pub.dev/packages/dio
    - Too lazy to repeat write network layer ? You could try to do it for us `retrofit-generator` https://pub.dev/packages/retrofit_generator
    - To use `source_gen`, please read here: https://medium.com/flutter-community/part-2-code-generation-in-dart-annotations-source-gen-and-build-runner-bbceee28697b
    and https://github.com/dart-lang/build/blob/master/docs/writing_a_builder.md#configuring-outputs

### Codebase Overview
This is a diagram that I drew to design and describe this codebase. (to view PDF version ![click here](files/Codebase%20Clean%20Architecture%20Flutter.drawio.pdf))
    ![alt text](files/Codebase%20Clean%20Architecture%20Flutter.drawio.png)

**Exception Flow**
    ![alt text](files/exception-handler.jpg)

## Architecture overview
It is architecture based on [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel), [CleanArchitecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) and the blog by [Reso Coder's Flutter Clean Architecture ](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/). The main focus of the architecture is separation of concerns and scalability.  I will apply this diagram to my mudules in my project.

![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1)
![alt text](files/clean%20architecture%20overview.jpeg)

Every "feature" of the app, like sign in with email and password, will be divided into 3 layers - `presentation`, `domain` and `data`.

**The Dependency Rule**

`Source code dependencies only point inwards`. This means inward modules are neither aware of nor dependent on outer modules. However, outer modules are both aware of and dependent on inner modules. The more you move inward, the more abstraction is present. The outer you move the more concrete implementations are present.

> IMPORTANT : Domain represents the inner-most layer. Therefore, it the most abstract layer in the architecture.

**Layers**

1. Domain
   It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.

   ![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/domain-layer-diagram.png?w=141&ssl=1)
   - `UseCase`: Classes which encapsulate all the business logic of a particular use case of the app (e.g. FetchProfile or UpdateProfile).
   - `Entities`: Business objects of the application
   - `Repositories`: Abstract classes that define the expected functionality of outer layers (`data` layer).

   I create an abstract Repository class defining a contract of what the Repository must do - this goes into the domain layer. I then depend on the Repository "contract" defined in `domain`, knowing that the actual implementation of the Repository in the `data` layer will fullfill this contract.
   > NOTE: Dependency inversion principle is the last of the SOLID principles. It basically states that the boundaries between layers should be handled with interfaces (abstract classes in Dart).

2. Data:
   Consists of a **Repository implementation** (the contract comes from the `domain` layer) and data sources - one is usually for getting remote (API) data and the other for caching that data.

   ![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/data-layer-diagram.png?w=329&ssl=1)
   - `Repositories`: Every Repository should implement Repository from the `domain` layer.
   - `Datasources`:
      - *remote* : responsible for any API call.
      - *local* : reposible for caching data in local database (e.g SQLite, shared_preferences)
   - `Models`: Extensions of `Entities` with the addition of extra members that might be platform-dependent. For example, in the case of parse json Oject from reponse's server, this can be add some specific functionality (toJson, fromJson) or additional fields database.
   > NOTE: You may notice that data sources don't return `Entities` but rather `Models`.

   > **Data Flow Detail:**
   ![alt text](files/data-flow.jpg)

3. Presentation:
   Contains the UI and the event handlers of the UI.

   ![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/presentation-layer-diagram.png?w=287&ssl=1)

