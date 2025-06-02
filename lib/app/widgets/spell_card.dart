import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

class SpellCard extends StatelessWidget {
  final bool isSmall;
  final SpellCardModel spellCardModel;
  const SpellCard({
    super.key,
    required this.spellCardModel,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5/8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
        ),
        color: spellCardModel.cardSpecial,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
            border: Border.all(
              color: Colors.black54,
              width: isSmall ? 3 : 8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmall? 2.0 : 4.0),
            child: Column(
              spacing: isSmall? 3: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isSmall? 3 : 6),
                  decoration: BoxDecoration(
                    color: spellCardModel.cardSpecial,
                    borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
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
                          fontSize: isSmall ? 6 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmall? 8 : 16
                  ),
                  child: Column(
                    spacing: isSmall ? 2 : 8 ,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          spellCardModel.level,
                              (index) => Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: isSmall ? 8 : 24,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(isSmall ? 3 : 8), // Bo góc
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
                          borderRadius: BorderRadius.circular( isSmall ? 4: 8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isSmall ? 3 : 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${spellCardModel.series}",
                                  style: TextStyle(
                                    fontSize: isSmall ? 6 : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  )
                              ),
                              Text(
                                  spellCardModel.description,
                                  style: TextStyle(
                                    fontSize: isSmall ? 5 : ((MediaQuery.sizeOf(context).width* 0.005)+(MediaQuery.sizeOf(context).height* 0.007)),
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
