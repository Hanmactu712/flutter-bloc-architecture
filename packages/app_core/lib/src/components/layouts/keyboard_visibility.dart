import 'package:flutter/material.dart';

class KeyboardVisibility extends StatefulWidget {
  final Widget Function(BuildContext context, double bottomInset) child;
  const KeyboardVisibility({super.key, required this.child});
  @override
  KeyboardVisibilityState createState() => KeyboardVisibilityState();
}

class KeyboardVisibilityState extends State<KeyboardVisibility> with WidgetsBindingObserver {
  double _bottomInset = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _bottomInset = View.of(context).viewInsets.bottom;
    });
    // Further logic can be added here based on _bottomInset value
    print('Bottom Inset changed: $_bottomInset');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child(context, _bottomInset),
    );
  }
}
