import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_versus/app/data/card_game/spell_card_data/crows_party.dart';
import 'package:nexus_versus/app/data/card_game/spell_card_data/war_peace.dart';
import 'package:nexus_versus/app/data/card_game/unit_card_data/black_crow.dart';
import 'package:nexus_versus/app/data/card_game/unit_card_data/red_cowboy.dart';
import 'package:nexus_versus/app/models/card_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/modules/debug_build/controllers/debug_build_controller.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/spell_card_onbattle.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';
import 'package:nexus_versus/app/widgets/unit_card_onbattle.dart';

class DebugBuildView extends GetView<DebugBuildController> {
  const DebugBuildView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    const double cardWidth = 150;
    const double cardOffset = 60.0;
    const double cardWidthOnbattle = 100;
    final cardList = controller.cardList;

    return Scaffold(
      body: Stack(
        children: [
          /// Nội dung chính bên trên

          Column(
            children: [
              Expanded(
                flex: 5,
                  child: Placeholder()
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // /// Lá bài được chọn
                          // Obx(() => SizedBox(
                          //   height: screenHeight * 0.6,
                          //   child: cardList[controller.selectedCardIndex.value] is UnitCardModel
                          //       ? UnitCard(
                          //     isSmall: false,
                          //     unitCardModel: cardList[controller.selectedCardIndex.value] as UnitCardModel,
                          //   )
                          //       : SpellCard(
                          //     isSmall: false,
                          //     spellCardModel: cardList[controller.selectedCardIndex.value] as SpellCardModel,
                          //   ),
                          // )),
                          //
                          // const SizedBox(height: 16),

                          /// Hàng gồm 5 ô
                          Obx(() => SizedBox(
                            height: screenHeight * 0.37,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Hàng trên: chỉ chứa UnitCardModel
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final card = controller.onField[index];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onField[index] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 1}"),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.cardList[controller.selectedCardIndex.value] is UnitCardModel) {
                                              controller.placeCardOnField(index,context);
                                            }
                                          },
                                          child: Container(
                                            width: cardWidthOnbattle,
                                            height: cardWidthOnbattle * (8 / 5),
                                            margin: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade600,
                                                  width: 4
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.transparent,
                                            ),
                                            child: card is UnitCardModel
                                                ? UnitCardOnBattle(unitCardModel: card)
                                                : Center(child: Text("Ô ${index + 1}")),
                                          ),
                                        ),
                                        if (card is UnitCardModel)
                                          Column(
                                            children: [
                                              Text("HP: ${card.healthPoints}", style: const TextStyle(fontSize: 12)),
                                              Text("ATK: ${card.attackPower}", style: const TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                      ],
                                    );
                                  }),
                                ),

                                // Hàng dưới: chỉ chứa SpellCardModel
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final card = controller.onField[index + 5];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onField[index + 5] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 6}"),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.cardList[controller.selectedCardIndex.value] is SpellCardModel) {
                                              controller.placeCardOnField(index + 5, context);
                                            }
                                          },
                                          child: Container(
                                            width: cardWidthOnbattle,
                                            height: cardWidthOnbattle * (8 / 5),
                                            margin: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.shade600, width: 4),
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.transparent,
                                            ),
                                            child: card is SpellCardModel
                                                ? SpellCardOnBattle(spellCardModel: card)
                                                : Center(child: Text("Ô ${index + 6}")),
                                          ),
                                        ),
                                        // if (card is SpellCardModel)
                                        //   Text("${card.name}", style: const TextStyle(fontSize: 12)),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Stack lá bài ở giữa phía dưới màn hình
          Obx(() {
            final cardList = controller.cardList;
            final int cardCount = cardList.length;
            final double totalWidth = (cardCount - 1) * cardOffset + cardWidth;
            return Positioned(
              bottom: 0,
              left: (screenWidth - totalWidth) / 2,
              child: SizedBox(
                width: totalWidth,
                height: screenHeight * 0.27,
                child: Stack(
                  children: List.generate(
                    cardList.length,
                        (index) {
                      final card = cardList[index];
                      final isHovered = controller.hoveredCardIndex.value == index;
                      final isSelected = controller.selectedCardIndex.value == index;
                      if (card == null) return const SizedBox();
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
                              controller.selectCard(index);
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
                )
              ),
            );
          })
        ],
      ),
    );
  }
}


