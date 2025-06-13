import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

class SpellCardOnBattle extends StatefulWidget {
  final SpellCardModel spellCardModel;
  final bool animateOnAppear;

  const SpellCardOnBattle({
    super.key,
    required this.spellCardModel,
    this.animateOnAppear = false,
  });

  @override
  State<SpellCardOnBattle> createState() => _SpellCardOnBattleState();
}

class _SpellCardOnBattleState extends State<SpellCardOnBattle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    if (widget.animateOnAppear) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spellCardModel = widget.spellCardModel;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AspectRatio(
        aspectRatio: 5 / 8,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          color: spellCardModel.cardSpecial,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: spellCardModel.cardSpecial,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          spellCardModel.name,
                          style: const TextStyle(
                            fontSize: 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stars & Image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                            spellCardModel.level,
                                (index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 4,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              spellCardModel.imageUrl,
                              alignment: Alignment.topLeft,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Description
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${spellCardModel.series}",
                                style: const TextStyle(
                                  fontSize: 3,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                spellCardModel.description,
                                style: const TextStyle(
                                  fontSize: 3,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
