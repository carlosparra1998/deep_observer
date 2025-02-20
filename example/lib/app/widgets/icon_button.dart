import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  const MyIconButton(this.icon, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: GestureDetector(onTap: onTap, child: Icon(icon, size: 30)),
    );
  }
}
