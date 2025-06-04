import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImageOverlay extends StatefulWidget {
  final String imagePath;
  final Duration duration;
  final VoidCallback onFinish;

  const FullScreenImageOverlay({
    required this.imagePath,
    required this.duration,
    required this.onFinish,
  });

  @override
  State<FullScreenImageOverlay> createState() => FullScreenImageOverlayState();
}

class FullScreenImageOverlayState extends State<FullScreenImageOverlay> with SingleTickerProviderStateMixin {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInAndOut();
  }

  void fadeInAndOut() async {
    // Fade in
    setState(() => opacity = 1.0);
    await Future.delayed(const Duration(milliseconds: 300));

    // Wait while image is fully shown
    await Future.delayed(widget.duration - const Duration(milliseconds: 600));

    // Fade out
    setState(() => opacity = 0.0);
    await Future.delayed(const Duration(milliseconds: 300));

    // Remove overlay
    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.black.withOpacity(0.85),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
