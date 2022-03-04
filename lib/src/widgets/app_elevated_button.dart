import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  const AppElevatedButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[300]),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16))),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
