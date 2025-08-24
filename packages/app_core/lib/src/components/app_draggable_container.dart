import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDraggableContainer extends StatefulWidget {
  final Widget child;
  final Widget? draggable;
  final Offset initialPosition;
  const AppDraggableContainer({
    super.key,
    required this.child,
    this.draggable,
    this.initialPosition = const Offset(10, 80),
  });

  @override
  State<AppDraggableContainer> createState() => _AppDraggableContainerState();
}

class _AppDraggableContainerState extends State<AppDraggableContainer> {
  Offset? currentPosition;
  final Future<SharedPreferences> instanceFuture = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    currentPosition = widget.initialPosition;

    //get position from shared preferences
    instanceFuture.then((instance) {
      var x = instance.getDouble('${widget.key}_x');
      var y = instance.getDouble('${widget.key}_y');
      if (x != null && y != null) {
        setState(() {
          currentPosition = Offset(x, y);
        });
      }
    });
  }

  setPositions(Offset offset) async {
    setState(() {
      currentPosition = offset;
    });
    var instance = await instanceFuture;
    await instance.setDouble('${widget.key}_x', offset.dx);
    await instance.setDouble('${widget.key}_y', offset.dy);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          widget.child,
          if (widget.draggable != null)
            Builder(builder: (context) {
              var defaultTop = 10;
              var defaultLeft = 50;
              var left = currentPosition?.dx ?? defaultLeft;
              var top = currentPosition?.dy ?? defaultTop;
              var realLeft = left.clamp(0, MediaQuery.of(context).size.width - 24).toDouble();
              var realTop = top.clamp(50, MediaQuery.of(context).size.height - 50).toDouble();

              return Positioned(
                left: realLeft,
                top: realTop,
                child: Draggable(
                  feedback: widget.draggable!,
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    setPositions(details.offset);
                  },
                  child: widget.draggable!,
                ),
              );
            }),
        ],
      ),
    );
  }
}
