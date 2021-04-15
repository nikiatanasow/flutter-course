import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _widthAnimation;
  Animation<double> _heightAnimation;
  Animation<Color> _colorAnimation;

  static const platform =
      const MethodChannel('platformcode.flutter.course/battery');

  String _batteryLevel = 'Unknown battery level.';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _widthAnimation = Tween<double>(begin: 100, end: 200).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.0, 0.5)));
    _heightAnimation = Tween<double>(begin: 100, end: 200).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.5, 1.0)));
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.25, 0.75)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: _widthAnimation.value,
                    height: _heightAnimation.value,
                    color: _colorAnimation.value,
                  );
                },
              ),
            ),
            Text(
              'Battery Level:',
            ),
            Text(
              '$_batteryLevel',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (Platform.isAndroid)
              CupertinoButton(child: Text('Button'), onPressed: () => {}),
            if (Platform.isIOS)
              ElevatedButton(onPressed: () => {}, child: Text('Button'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getBatteryLevel(),
        tooltip: 'Get battery level',
        child: Icon(Icons.battery_full),
      ),
    );
  }
}
