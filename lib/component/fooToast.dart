import 'package:flutter/material.dart';

class FooToast extends StatelessWidget {
  final bool isGreen;
  final String text;
  FooToast({this.isGreen, this.text});
  @override
  Widget build(BuildContext context) {
    return (isGreen) ? _GreenToast(text) : _RedToast(text);
  }
}

class _GreenToast extends StatelessWidget {
  final String text;
  _GreenToast(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );
  }
}

class _RedToast extends StatelessWidget {
  final String text;
  _RedToast(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Icon(Icons.close),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );
  }
}
