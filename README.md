# flutter_bloc_architecture_template

A Flutter project template using the BLoC architecture.

## Sample images

<img src="assets/images/light_small.png.png">

## Getting Started

To get started with this template, follow these steps:

1. Clone the repository:

   ```
   git clone https://github.com/your_username/flutter_bloc_architecture_template.git
   ```

2. Navigate to each package in the `packages` directory:

   ```
   cd ./packages/<package_name>
   ```

3. Install the dependencies:

   ```
   flutter pub get
   ```

4. Install the dependencies of the root project:

   ```
   cd ..
   flutter pub get

   ```

5. Run the application:
   ```
   flutter run
   ```

## Features

- BLoC architecture
- Modular design
- Easy to customize
- Material Design 3
- Using [go_router](https://pub.dev/packages/go_router) for navigation
- Multilanguage support (using [flutter_localizations](https://pub.dev/packages/flutter_localizations))
- Dynamic theming & dark mode support
- Responsive design
- Apply canonical design principles for responsive layouts. [Learn more](https://m3.material.io/foundations/layout/canonical-layouts/overview)
- Using Dio for networking. [Learn more](https://pub.dev/packages/dio)

### Common Folder Structure applied for either package or main project

```
lib/
├── I10n                          //contains all the localization files
│   ├── locale_file.arb
│   └── ...
├── src
│   ├── common/                   //contains all the common parts and utilities such as routers, constants, enum, dependencies injection
│   │   ├── constants.dart
│   │   ├── enums.dart
│   │   ├── di_config.dart
│   │   ├── common.dart           //the consolidated file for common utilities, usually export all the others parts of whole folder
│   │   └── ...
│   ├── components/               //contains all the reusable UI components, widgets, and styles
│   │   ├── component_1.dart
│   │   ├── component_2.dart
│   │   ├── component_3.dart
│   │   ├── components.dart       //the consolidated file for all components/widgets, usually export all the others components/widgets of whole folder
│   │   └── ...
│   ├── repositories/             //contains all the repositories to manage the data layer
│   │   ├── repository_1.dart
│   │   ├── repository_2.dart
│   │   ├── repository_3.dart
│   │   ├── repositories.dart       //the consolidated file for all repositories, usually export all the others repositories of whole folder
│   │   └── ...
│   ├── services/                   //contains all the services to service the business logic or api call
│   │   ├── service_1.dart
│   │   ├── service_2.dart
│   │   ├── service_3.dart
│   │   ├── services.dart       //the consolidated file for all services, usually export all the others services of whole folder
│   │   └── ...
│   ├── pages/                   //contains all the pages/screens/widgets of a specific module/package
│   │   ├── page_1.dart
│   │   ├── page_2.dart
│   │   ├── page_3.dart
│   │   ├── pages.dart       //the consolidated file for all pages/screens/widgets, usually export all the others pages/screens/widgets of whole folder
│   │   └── ...
│   ├── localization/
│   │   ├── localization.dart         //generated files by flutter_localizations
│   │   └── ...
└── main.dart                     //the entry point of the application
```

## Configuration

### Change the package name

To change the package app name, using the package `change_app_package_name`.
Add the package to `dev_dependencies` in your `pubspec.yaml` file:

```
dev_dependencies:
  change_app_package_name: ^1.4.0
```

or run the command

```
flutter pub add --dev change_app_package_name
```

Then, run the following command to change the package name:

```
dart run change_app_package_name:main com.new.package.name
```

Refer to the [documentation](https://pub.dev/packages/change_app_package_name) for more information.

### Change the app launcher icon

To change the app launcher icon, you can use the `flutter_launcher_icons` package. Add the package to your `pubspec.yaml` file:

```
dev_dependencies:
  flutter_launcher_icons: ^0.9.2
```

or run the command

```
flutter pub add --dev flutter_launcher_icons
```

Then, configure the package in your `app_launcher_icons.yaml` file:

```
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
```

Finally, run the following command to generate the app icons:

```
dart run flutter_launcher_icons -f app_launcher_icons.yaml
```

Refer to the [documentation](https://pub.dev/packages/flutter_launcher_icons) for more information.

### Change the splash screen

To change the splash screen, you can use the `flutter_native_splash` package. Add the package to your `pubspec.yaml` file:

```
dev_dependencies:
  flutter_native_splash: ^2.0.5
```

or run the command

```
flutter pub add --dev flutter_native_splash
```

Then, configure the package in your `app_native_splash.yaml` file:

```
flutter_native_splash:
  color: "#ffffff"
  image: assets/icon/app_icon.png
  android: true
  ios: true
```

Finally, run the following command to generate the splash screen:

```
dart run flutter_native_splash:create --path=app_native_splash.yaml
```

Refer to the [documentation](https://pub.dev/packages/flutter_native_splash) for more information.
