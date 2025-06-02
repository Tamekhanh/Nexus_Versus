import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

class UnitCard extends StatelessWidget {
  final bool isSmall;
  final UnitCardModel unitCardModel;

  const UnitCard({
    super.key,
    required this.unitCardModel,
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
        color: unitCardModel.cardSpecial,
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
                    color: unitCardModel.cardSpecial,
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
                        unitCardModel.name,
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
                          unitCardModel.level,
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
                              unitCardModel.imageUrl,
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
                                  "${unitCardModel.series}",
                                  style: TextStyle(
                                    fontSize: isSmall ? 6 : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  )
                              ),
                              Text(
                                  unitCardModel.description,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmall ? 4 : 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: isSmall ? 3 : 8,
                    children: [
                      Text(
                        'Atk/ ${unitCardModel.attackPower}',
                        style: TextStyle(
                          fontSize: isSmall ? 6 : 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Hp/ ${unitCardModel.healthPoints}',
                        style: TextStyle(
                          fontSize: isSmall ? 6 : 16,
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
    );
  }
}
