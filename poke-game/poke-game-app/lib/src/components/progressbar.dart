import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final double value;

  ProgressBar({required this.height, required this.width, required this.value});

  @override
  State<StatefulWidget> createState() => _ProgressBarState(
      height: this.height, width: this.width, value: this.value);
}

class _ProgressBarState extends State<ProgressBar> {
  final double width;
  final double value;
  final double height;

  _ProgressBarState(
      {required this.height, required this.width, required this.value});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        child: Row(
          children: [
            Container(
              color: Colors.blue.shade500,
              width: value,
              height: this.height,
            ),
            Container(
                color: Colors.blue.shade100,
                height: this.height,
                width: width - value)
          ],
        ));
  }
}
