import 'package:flutter/material.dart';

class NoGroupScreen extends StatefulWidget {
  @override
  _NoGroupScreenState createState() => _NoGroupScreenState();
}

class _NoGroupScreenState extends State<NoGroupScreen> {
  final duration = 200;
  final double maxSlide = 300;
  final minSwipeVelocity = 700;

  double delta = 0;
  double targetDX = 0;
  double currentDX = 0;
  bool isOpen = false;

  void _toogleIsOpen() {
    print('toggling !');
    this.isOpen = !this.isOpen;
  }

  void _onHorizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      double dx = details.globalPosition.dx.floorToDouble();

      this.targetDX = dx > this.maxSlide ? this.maxSlide : dx;
      this.currentDX = dx;
      this.delta = details.delta.dx.floorToDouble();
    });
  }

  void _onVerticalDragUpdateHandler(DragUpdateDetails details) {}

  void _onDragEnd(DragEndDetails details, BuildContext context) {
    double velocity = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();

    setState(() {
      if (velocity > this.minSwipeVelocity) {
        if (this.delta > 0) {
          this.targetDX = maxSlide;
        } else {
          this.targetDX = 0;
        }
      } else {
        final screenWidth = MediaQuery.of(context).size.width;
        if (this.currentDX > screenWidth / 2) {
          this.targetDX = maxSlide;
        } else {
          this.targetDX = 0;
        }
      }
      _toogleIsOpen();
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {}

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(targetDX, 0, 0),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOut,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdateHandler,
        onVerticalDragUpdate: null,
        onHorizontalDragEnd: (details) => _onDragEnd(details, context),
        onVerticalDragEnd: null,
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  this.targetDX = this.isOpen ? 0 : this.maxSlide;
                  _toogleIsOpen();
                });
              },
            ),
            title: Text('Welcome'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          bottomLeft: const Radius.circular(30.0),
        ),
      ),
    );
  }
}
