import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/card_list/controllers/card_list_controller.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';

class CardListView extends GetView<CardListController> {
  const CardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔲 Main Content
        Expanded(
          child: Row(
            children: [
              // 🔹 Large Preview
              Expanded(
                flex: 1,
                child: Obx(() {
                  final cards = controller.cardList;
                  if (cards.isEmpty) return const Center(child: Text("No cards available"));
                  final selectedCard = cards[controller.selectedCardIndex.value];
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: SizedBox(
                      key: ValueKey(selectedCard.id),
                      height: MediaQuery.sizeOf(context).height * 0.75,
                      child: selectedCard is UnitCardModel
                          ? UnitCard(isSmall: false, unitCardModel: selectedCard)
                          : SpellCard(isSmall: false, spellCardModel: selectedCard as SpellCardModel),
                    ),
                  );
                }),
              ),

              // 🔹 Grid List
              Expanded(
                flex: 2,
                child: Obx(() {
                  final cards = controller.cardList;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔽 Filter Dropdown
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<CardFilterType>(
                          value: controller.filterType.value,
                          onChanged: (value) {
                            if (value != null) {
                              controller.filterType.value = value;
                              controller.selectedCardIndex.value = 0;
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: CardFilterType.all,
                              child: Text('All Cards'),
                            ),
                            DropdownMenuItem(
                              value: CardFilterType.spell,
                              child: Text('Spell Cards'),
                            ),
                            DropdownMenuItem(
                              value: CardFilterType.unit,
                              child: Text('Unit Cards'),
                            ),
                          ],
                        ),
                      ),

                      // 🧩 Grid View in Expanded
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final card = cards[index];
                            final cardWidget = card is UnitCardModel
                                ? UnitCard(isSmall: true, unitCardModel: card)
                                : SpellCard(isSmall: true, spellCardModel: card as SpellCardModel);

                            return GestureDetector(
                              onTap: () {
                                controller.selectedCardIndex.value = index;
                              },
                              child: cardWidget,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
