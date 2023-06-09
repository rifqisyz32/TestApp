import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const CartBadge({
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color ?? Colors.green,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
