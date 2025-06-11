import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';

class CardReviveEffect extends StatefulWidget {
  final UnitCardModel unitCardModel;
  final Duration duration;
  final VoidCallback onFinish;
  final Text? text; // Optional text

  const CardReviveEffect({
    required this.unitCardModel,
    required this.duration,
    required this.onFinish,
    this.text,
  });

  @override
  State<CardReviveEffect> createState() => _CardReviveEffectState();
}

class _CardReviveEffectState extends State<CardReviveEffect> with TickerProviderStateMixin {
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
    return Positioned(
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
                child: UnitCard(unitCardModel: widget.unitCardModel, isSmall: false,)
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

showCardReviveEffect(
    BuildContext context,
    UnitCardModel unitCardModel, {
      Duration duration = const Duration(seconds: 1),
      Text? text,
    }) {
  final overlay = Overlay.of(context);
  late final OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => CardReviveEffect(
      unitCardModel: unitCardModel,
      duration: duration,
      text: text,
      onFinish: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);
}
