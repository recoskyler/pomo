# Pomo

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

<a href='https://ko-fi.com/recoskyler' target='_blank'><img height='35' style='border:0px;height:46px;' src='https://az743702.vo.msecnd.net/cdn/kofi3.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com'></a>

A simple, cross-platform Pomodoro timer app with WebHook support.

![Dark Mode Screenshot](https://github.com/recoskyler/pomo/blob/main/assets/images/screenshot_dark.png?raw=true)

![Light Mode Screenshot](https://github.com/recoskyler/pomo/blob/main/assets/images/screenshot_light.png?raw=true)

![Settings Page Screenshot](https://github.com/recoskyler/pomo/blob/main/assets/images/settings.png?raw=true)

---

## 🌟 Features

- ⏱ Adjustable work, short break, and long break durations
- 👏 Adjustable lap count
- 🌐 Webhook integration
- 🌛 Light/Dark theme
- 🌈 Themes in a variety of colors
- ⏰ Customizable timer font
- 📢 Customizable sounds

## ⌨ Keyboard Shortcuts

- <kbd>Space</kbd> or <kbd>Enter</kbd> to start/pause the timer
- <kbd>s</kbd> to skip the lap
- <kbd>r</kbd> or <kbd>BackSpace</kbd> to reset the timer

## 🌐 Using WebHooks

You can configure WebHooks from the **Settings** page. When a webhook is triggered, RGB color data in JSON format will be sent along (check below). This RGB color data corresponds to the color of the circular progress indicator on the home page. You can see an example of this data below:

```json
{
    "rgb": [
        255, // RED Value
        0,   // GREEN Value
        156, // BLUE Value
    ]
}
```

### Triggering multiple webhooks

If you would like to trigger multiple WebHook URLs from a single event, you can enter multiple URLs separated by a comma. e.g.:

`https://example.com/api/v1/webhooks/start,https://example2.com/api/v1/webhooks/toggle`

### HomeAssistant Integration

The main reason I created this application was to use these WebHooks to control my ambient light using HomeAssistant. If you have an RGB(W) LED bulb connected to HomeAssistant, you can [create a new WebHook automation](https://www.home-assistant.io/docs/automation/trigger/#webhook-trigger), and use the sample configuration below to set your light bulb's color to the data provided by Pomo:

```yaml
alias: Timer Tick Webhook
description: "Runs every second, whenever Pomo ticks."
trigger:
  - platform: webhook
    allowed_methods:
      - POST
      - PUT
    local_only: true
    webhook_id: "-YOUR_WEBHOOK_ID"
condition:
  - condition: device
    type: is_on
    device_id: REPLACE_WITH_DEVICE_ID
    entity_id: REPLACE_WITH_ENTITY_ID
    domain: light
action:
  - service: light.turn_on
    metadata: {}
    data:
      rgb_color: "{{ trigger.json['rgb'] }}"
      transition: 1
    target:
      entity_id: light.192_168_1_3
mode: single
```

## Installing

You can either download and install one of the already-built [releases](https://github.com/recoskyler/pomo/releases), or [build it yourself](#building).

## Development

### Tech Stack

- Flutter 3.27.1
- Dart 3.5.4

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Pomo works on iOS, Android, Web, Linux, MacOS, and Windows._

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:pomo/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
...

<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
</array>

...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "timer": "Timer"
    ...
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

### Generating Splash Screens

To use the latest splash screen changes, you will need to generate them:

```sh
dart run flutter_native_splash:create
```

### Generating Launcher Icons

To use the latest launcher icon (`<project root>/assets/images/pomo_logo.png`) changes, you will need to generate them:

```sh
dart run flutter_launcher_icons
```

## Building

### Building for the web

1. Enable web support:

    ```bash
    $ flutter config --enable-web
    ```

2. Build the web app:

    ```bash
    $ flutter build web --release -o docs
    ```

### Building .APK

Follow the steps [here](https://docs.flutter.dev/deployment/android). Make sure to create a keystore.

```bash
$ flutter build apk
```

### Building .DEB & .RPM (on Ubuntu 22.04)

More info [here](https://docs.flutter.dev/deployment/linux) and [here](https://medium.com/@fluttergems/packaging-and-distributing-flutter-desktop-apps-the-missing-guide-part-3-linux-24ef8d30a5b4).

1. Install and activate the `flutter_distributor` plugin:

    ```bash
    $ flutter pub global activate flutter_distributor
    ```

2. Install the OS dependencies:

    ```bash
    $ sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad libgtk-3-0 libblkid1 liblzma5
    ```

3. Enable Linux desktop support:

    ```bash
    $ flutter config --enable-linux-desktop
    ```

#### Building .DEB

```bash
$ flutter_distributor release --name=dev --jobs=release-dev-linux-deb
```

#### Building .RPM

```bash
$ sudo apt-get install rpm patchelf

$ flutter_distributor release --name=dev --jobs=release-dev-linux-rpm
```

### Building .EXE

[*good luck*](https://medium.com/@fluttergems/packaging-and-distributing-flutter-desktop-apps-the-missing-guide-part-2-windows-0b468d5e9e70)

[help](https://docs.flutter.dev/deployment/windows)

## About

By [recoskyler](https://github.com/recoskyler) - 2024

- Used **Major Mono Display** font by *Emre Parlak*.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
