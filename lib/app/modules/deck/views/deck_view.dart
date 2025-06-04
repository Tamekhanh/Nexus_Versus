import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/card_reformat.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';
import 'package:nexus_versus/app/modules/deck/controllers/deck_controller.dart';

class DeckView extends GetView<DeckController> {
  const DeckView({super.key});

  Widget _buildDeck(RxList<CardModel> deck) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () {
              controller.clearCurrentDeck();
            },
            child: Text("Clear All Card"),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2 / 3,
            ),
            itemCount: deck.length,
            itemBuilder: (_, index) {
              final card = deck[index];
              final widget = card is UnitCardModel
                  ? UnitCard(isSmall: true, unitCardModel: card)
                  : SpellCard(isSmall: true, spellCardModel: card as SpellCardModel);

              return GestureDetector(
                onTap: () {
                  controller.removeCardFromCurrentDeck(card);
                },
                child: widget,
              );
            },
          ),
        ),
      ],
    ));
  }


  @override
  Widget build(BuildContext context) {
    final allCards = cardData.values.toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Row(
          children: [
            // Bên trái: Deck
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TabBar(
                    onTap: (index) => controller.setCurrentDeck(index),
                    tabs: const [
                      Tab(text: "Deck 1"),
                      Tab(text: "Deck 2"),
                      Tab(text: "Deck 3"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildDeck(controller.deck1),
                        _buildDeck(controller.deck2),
                        _buildDeck(controller.deck3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 1),
            // Bên phải: Grid card để chọn thêm vào deck
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: allCards.length,
                  itemBuilder: (context, index) {
                    final card = allCards[index];
                    final widget = card is UnitCardModel
                        ? UnitCard(isSmall: true, unitCardModel: card)
                        : SpellCard(isSmall: true, spellCardModel: card as SpellCardModel);

                    return GestureDetector(
                      onTap: () {
                        controller.addCardToCurrentDeck(card);
                      },
                      child: widget,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
