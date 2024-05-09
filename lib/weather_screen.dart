import 'package:flutter/material.dart';

enum Weather {
  sunny(
    '晴れ',
    Icons.sunny,
    Colors.amber,
  ),
  cloudy(
    '曇り',
    Icons.cloud,
    Colors.black,
  ),
  rain('雨', Icons.grain, Colors.blue),
  snow(
    '雪',
    Icons.ac_unit,
    Color.fromARGB(255, 144, 138, 138),
  );

  const Weather(this.text, this.icon, this.color);

  final String text;
  final IconData icon;
  final Color color;
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: const Text('Golden Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: Weather.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (_, index) => WeatherScreenItem(
            weather: Weather.values[index],
          ),
        ),
      ),
    );
  }
}

class WeatherScreenItem extends StatelessWidget {
  const WeatherScreenItem({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: weather.color,
              ),
              width: 200,
              height: 200,
            ),
            Positioned(
              left: -80,
              top: -80,
              child: Icon(
                weather.icon,
                color: Colors.white,
                size: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  weather.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
