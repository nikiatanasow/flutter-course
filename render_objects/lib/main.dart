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
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: FlutterBorder(
            child: Text(
              'You have pushed the button this many times:',
            ),
          ),
        ),
        // RadBorder(
        //   color: Colors.orange,
        //   thickness: 10.0,
        //   child: Text(
        //     'You have pushed the button this many times:',
        //   ),
        // ),
      ),
    );
  }
}

class FlutterBorder extends StatefulWidget {
  final Color color;
  final double thickness;
  final Widget child;

  const FlutterBorder({
    Key key,
    this.color = Colors.blue,
    this.thickness = 10,
    this.child,
  }) : super(key: key);

  @override
  _FlutterBorderState createState() => _FlutterBorderState();
}

class _FlutterBorderState extends State<FlutterBorder> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(200, 50)),
      child: CustomPaint(
        painter: _FlutterBorderPainter(
          color: widget.color,
          thickness: widget.thickness,
        ),
        child: CustomSingleChildLayout(
          delegate: _FlutterBorderLayoutDelegate(
            thickness: widget.thickness,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _FlutterBorderLayoutDelegate extends SingleChildLayoutDelegate {
  final double thickness;

  _FlutterBorderLayoutDelegate({this.thickness});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final width = constraints.maxWidth - (thickness * 2);
    final height = constraints.maxHeight - (thickness * 2);
    BoxConstraints measureConstraint = BoxConstraints.loose(
      Size(
        width > 0 ? width : 0,
        height > 0 ? height : 0,
      ),
    );
    return measureConstraint;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    final size = super.getSize(constraints);
    return size;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final childOffset = super.getPositionForChild(size, childSize);
    final offset = Offset(thickness, thickness) + childOffset;
    return offset;
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => true;
}

class _FlutterBorderPainter extends CustomPainter {
  final Color color;
  final double thickness;

  _FlutterBorderPainter({this.color, this.thickness});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;

    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
      final width = constraints.maxWidth - (_thickness * 2);
      final height = constraints.maxHeight - (_thickness * 2);
      BoxConstraints measureConstraint = BoxConstraints.loose(
        Size(
          width > 0 ? width : 0,
          height > 0 ? height : 0,
        ),
      );
      child.layout(measureConstraint, parentUsesSize: true);
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
