import 'package:flutter/material.dart';

class FullScreenImageOverlay extends StatefulWidget {
  final String imagePath;
  final Duration duration;
  final VoidCallback onFinish;
  final Text? text; // Optional text

  const FullScreenImageOverlay({
    required this.imagePath,
    required this.duration,
    required this.onFinish,
    this.text,
  });

  @override
  State<FullScreenImageOverlay> createState() => _FullScreenImageOverlayState();
}

class _FullScreenImageOverlayState extends State<FullScreenImageOverlay> with TickerProviderStateMixin {
  double opacity = 0.0;
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _shakeAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    fadeInAndOut();
  }

  Future<void> fadeInAndOut() async {
    // Fade in
    setState(() => opacity = 1.0);
    await Future.delayed(const Duration(milliseconds: 300));

    // Wait during visible duration
    await Future.delayed(widget.duration - const Duration(milliseconds: 600));

    // Fade out
    setState(() => opacity = 0.0);
    await Future.delayed(const Duration(milliseconds: 300));

    _shakeController.stop();
    widget.onFinish();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.black.withOpacity(0.85),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              if (widget.text != null)
                Center(
                  child: AnimatedBuilder(
                    animation: _shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: child,
                      );
                    },
                    child: widget.text
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void showFullScreenImage(
    BuildContext context,
    String imagePath, {
      Duration duration = const Duration(seconds: 1),
      Text? text,
    }) {
  final overlay = Overlay.of(context);
  late final OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => FullScreenImageOverlay(
      imagePath: imagePath,
      duration: duration,
      text: text,
      onFinish: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);
}
