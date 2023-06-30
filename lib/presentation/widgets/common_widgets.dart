//common white shade design

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuBox extends StatefulWidget {
  final child;
  NeuBox({super.key, required this.child});

  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: widget.child,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 15,
                offset: Offset(
                  5,
                  5,
                )),
            BoxShadow(
                color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
          ]),
    );
  }
}