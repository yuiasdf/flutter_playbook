import 'package:flutter/material.dart';
import 'package:flutter_playground/weather_widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  // ゴールデンテストを定義するための関数
  testGoldens(
    'Weather Screen Test',
    (tester) async {
      await loadAppFonts();

      // 異なるデバイスサイズでWidgetをテストするために使用
      final builder = DeviceBuilder()
        // デバイスの種類を指定。指定した種類分スクリーンショットが作成されます。
        ..overrideDevicesForAllScenarios(devices: [
          Device.phone,
          Device.iphone11,
        ])
        // テストするシナリオを追加。今回はWeatherScreen全体をテスト。
        ..addScenario(
            widget: testableWidget(
          child: const WeatherScreen(),
        ));
      // addScenarioで指定したWidgetをレンダリング
      await tester.pumpDeviceBuilder(
        builder,
      );

      // レンダリングされたWidgetのスクリーンショットを作成し、第二引数で指定したファイルと比較します。
      await screenMatchesGolden(tester, 'weather_screen_test');
    },
  );

  testGoldens(
    'Weather Screen Item Test',
    (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        // 横に配置するコンポーネントの数
        columns: 2,
        // カラム数と幅と高さの比率
        widthToHeightRatio: 1,
      )
        // 各Enumの値でシナリオを作成
        ..addScenario(
          'Sunny',
          const WeatherScreenItem(weather: Weather.sunny),
        )
        ..addScenario(
          'Cloudy',
          const WeatherScreenItem(weather: Weather.cloudy),
        )
        ..addScenario(
          'Raining',
          const WeatherScreenItem(weather: Weather.rain),
        )
        ..addScenario(
          'Snow',
          const WeatherScreenItem(weather: Weather.snow),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
      );

      await screenMatchesGolden(
        tester,
        'weather_types_grid',
        autoHeight: true,
      );
    },
  );
}

Widget testableWidget({required Widget child}) {
  return MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      fontFamily: 'Murecho',
    ),
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
