import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';

import '../controllers/card_list_controller.dart';

class CardListView extends GetView<CardListController> {
  const CardListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Obx(() {
                final selectedCard = controller.cardList[controller.selectedCardIndex.value];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: SizedBox(
                    key: ValueKey(selectedCard.id), // đảm bảo AnimatedSwitcher biết khi nào thay đổi
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    child: selectedCard is UnitCardModel
                        ? UnitCard(
                      isSmall: false,
                      unitCardModel: selectedCard,
                    )
                        : SpellCard(
                      isSmall: false,
                      spellCardModel: selectedCard as SpellCardModel,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // chiều rộng tối đa cho mỗi card
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 2 / 3, // hoặc bất kỳ tỷ lệ nào thẻ bạn mong muốn
            ),
            itemCount: controller.cardList.length,
            itemBuilder: (context, index) {
              final card = controller.cardList[index];
              final isSelected = controller.selectedCardIndex.value == index;
              final cardWidget = card is UnitCardModel
                  ? UnitCard(isSmall: true, unitCardModel: card)
                  : SpellCard(isSmall: true,spellCardModel: card as SpellCardModel);
              return GestureDetector(
                  onTap: () {
                    controller.selectedCardIndex.value = index;
                  },
                  child: cardWidget
              );
            },
          ),
        ),
      ],
    );
  }
}
