import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';

class CardInformationDialog extends StatelessWidget {
  final CardModel card;

  const CardInformationDialog({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: card is UnitCardModel ?
          UnitCard(unitCardModel: card as UnitCardModel, isSmall: false) :
          card is SpellCardModel ?
              SpellCard(spellCardModel: card as SpellCardModel, isSmall: false) :
              Text('Unknown card type'),
      // content: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     if (card is UnitCardModel) ...[
      //       UnitCard(unitCardModel: card as UnitCardModel, isSmall: false)
      //     ] else if (card is SpellCardModel) ...[
      //       SpellCard(spellCardModel: card as SpellCardModel, isSmall: false)
      //     ]
      //   ],
      // ),
      // actions: [
      //   TextButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     child: const Text('Close'),
      //   )
      // ],
    );
  }
}