import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Icon icon;
  final Color? color;
  final void Function()? onTap;
  const MyButton({Key? key, required this.icon, this.color, this.onTap})
      : super(key: key); // Fix constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: icon,
      ),
    );
  }
}
