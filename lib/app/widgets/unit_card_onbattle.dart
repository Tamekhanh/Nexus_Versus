import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

class UnitCardOnBattle extends StatefulWidget {
  final UnitCardModel unitCardModel;
  final bool animateOnAppear;

  const UnitCardOnBattle({
    super.key,
    required this.unitCardModel,
    this.animateOnAppear = false,
  });

  @override
  State<UnitCardOnBattle> createState() => _UnitCardOnBattleState();
}

class _UnitCardOnBattleState extends State<UnitCardOnBattle> with SingleTickerProviderStateMixin {
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
    final unitCardModel = widget.unitCardModel;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AspectRatio(
        aspectRatio: 5 / 8,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          color: unitCardModel.cardSpecial,
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
                      color: unitCardModel.cardSpecial,
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
                          unitCardModel.name,
                          style: const TextStyle(
                            fontSize: 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Image & Stars
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                            unitCardModel.level,
                                (index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 4,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                alignment: Alignment.topLeft,
                                unitCardModel.imageUrl,
                                fit: BoxFit.cover,
                              ),
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
                                "${unitCardModel.series}",
                                style: const TextStyle(
                                  fontSize: 3,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                unitCardModel.description,
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
                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Atk/ ${unitCardModel.attackPower}',
                          style: const TextStyle(
                            fontSize: 3,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 1),
                        Text(
                          'Hp/ ${unitCardModel.healthPoints}',
                          style: const TextStyle(
                            fontSize: 3,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
