import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RadBorder(
          color: Colors.orange,
          thickness: 10.0,
          child: Text(
            'You have pushed the button this many times:',
          ),
        ),
      ),
    );
  }
}

class RadBorder extends SingleChildRenderObjectWidget {
  const RadBorder({
    Key key,
    Widget child,
    this.color = Colors.blue,
    this.thickness = 5.0,
  }) : super(key: key, child: child);

  final Color color;
  final double thickness;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RadBorderRenderObject(
        color: color,
        thickness: thickness,
      );

  @override
  void updateRenderObject(
      BuildContext context, covariant _RadBorderRenderObject renderObject) {
    renderObject
      ..color = color
      ..thickness = thickness;
  }
}

class _RadBorderRenderObject extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  Color _color;
  double _thickness;

  _RadBorderRenderObject({
    Color color,
    double thickness,
  })  : _color = color,
        _thickness = thickness;

  set color(Color color) {
    _color = color;
  }

  Color get color => _color;

  set thickness(double thickness) {
    _thickness = thickness;
  }

  double get thickness => _thickness;

  @override
  void performLayout() {
    if (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);
      final BoxParentData parentData = child.parentData as BoxParentData;
      parentData.offset = Offset(_thickness, _thickness);

      size = Size(child.size.width + (_thickness * 2),
          child.size.height + (_thickness * 2));
    } else {
      size = Size.zero;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    if (child != null) {
      final BoxParentData parentData = child.parentData as BoxParentData;
      context.paintChild(child, offset + parentData.offset);

      final Paint paint = Paint();
      paint.color = _color;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = _thickness;

      context.canvas.drawRect(
        Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
        paint,
      );
    }
  }
}
