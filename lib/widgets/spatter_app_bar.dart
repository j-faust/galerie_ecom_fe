import 'package:flutter/material.dart';
import 'spatter_painter.dart'; // import your painter

class SpatterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  const SpatterAppBar({super.key, required this.title,  this.actions, this.centerTitle = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // allow the background to show
      child: Stack(
        children: [
          // Spatter background
          CustomPaint(
            painter: SpatterPainter(),
            child: Container(height: preferredSize.height, color: Colors.black),
          ),
          // AppBar title and actions
          AppBar(
            title: Text(title),
            backgroundColor: Colors.transparent, // no solid color overlay
            actions: actions,
            elevation: 0,
            centerTitle: centerTitle,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
