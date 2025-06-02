import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

class SpellCardOnBattle extends StatelessWidget {
  final SpellCardModel spellCardModel;

  const SpellCardOnBattle({
    super.key,
    required this.spellCardModel,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5/8,
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
            padding: EdgeInsets.all(1),
            child: Column(
              spacing: 2,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: spellCardModel.cardSpecial,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
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
                        style: TextStyle(
                          fontSize: 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4
                  ),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          spellCardModel.level,
                              (index) => Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 4,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3), // Bo góc
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              alignment: Alignment.topLeft,
                              spellCardModel.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${spellCardModel.series}",
                                  style: TextStyle(
                                    fontSize: 3,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  )
                              ),
                              Text(
                                  spellCardModel.description,
                                  style: TextStyle(
                                    fontSize: 3,
                                    color: Colors.black54,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
