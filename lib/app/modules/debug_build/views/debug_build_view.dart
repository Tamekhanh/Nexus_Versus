import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/spell_card_data/crows_party.dart';
import 'package:nexus_versus/app/data/card_game/spell_card_data/war_peace.dart';
import 'package:nexus_versus/app/data/card_game/unit_card_data/black_crow.dart';
import 'package:nexus_versus/app/data/card_game/unit_card_data/red_cowboy.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/debug_build/controllers/debug_build_controller.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';

class DebugBuildView extends GetView<DebugBuildController> {
  const DebugBuildView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    const double cardWidth = 150;
    const double cardOffset = 60.0;
    final cardList = controller.cardList;
    final int cardCount = cardList.length;
    final double totalWidth = (cardCount - 1) * cardOffset + cardWidth;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DebugBuildView'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          /// Nội dung chính bên trên

          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Obx(
                      ()=> SizedBox(
                        height: screenHeight * 0.75,
                        child: cardList[controller.selectedCardIndex.value] is UnitCardModel
                            ? UnitCard(
                          isSmall: false,
                          unitCardModel: cardList[controller.selectedCardIndex.value] as UnitCardModel,
                        )
                            : SpellCard(
                          isSmall: false,
                          spellCardModel: cardList[controller.selectedCardIndex.value] as SpellCardModel,
                        ),
                      ),
                )
              ],
            ),
          ),

          /// Stack lá bài ở giữa phía dưới màn hình
          Positioned(
            bottom: 0,
            left: (screenWidth - totalWidth) / 2,
            child: SizedBox(
              width: totalWidth,
              height: screenHeight * 0.4,
              child: Obx(() {
                final cardList = controller.cardList;
                return Stack(
                  children: List.generate(
                    cardCount,
                        (index) {
                      final card = cardList[index];
                      final isHovered = controller.hoveredCardIndex.value == index;
                      final isSelected = controller.selectedCardIndex.value == index;
                      final cardWidget = card is UnitCardModel
                          ? UnitCard(isSmall: true, unitCardModel: card)
                          : SpellCard(isSmall: true,spellCardModel: card as SpellCardModel);
                      return Positioned(
                        left: index * cardOffset,
                        child: MouseRegion(
                          onEnter: (_) => controller.hoveredCardIndex.value = index,
                          onExit: (_) => controller.hoveredCardIndex.value = -1,
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedCardIndex.value = index;
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.translationValues(0, isHovered | isSelected ? -40 : 0, 0),
                              child: SizedBox(
                                width: cardWidth,
                                child: cardWidget
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
