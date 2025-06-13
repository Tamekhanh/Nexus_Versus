import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nexus_versus/app/models/in_battle_model.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';
import 'package:nexus_versus/app/widgets/spell_card.dart';
import 'package:nexus_versus/app/widgets/spell_card_onbattle.dart';
import 'package:nexus_versus/app/widgets/unit_card.dart';
import 'package:nexus_versus/app/widgets/unit_card_onbattle.dart';

import '../controllers/battle_controller.dart';

class BattleView extends GetView<BattleController> {
  const BattleView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    const double cardWidth = 150;
    const double cardOffset = 60.0;
    const double cardWidthOnbattle = 100;
    final handCards = controller.handCardsP2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BattleController>().setBattleContext(context);
    });

    return Scaffold(
      body: Stack(
        children: [
          /// Nội dung chính bên trên

          Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Hàng gồm 5 ô
                          Obx(() => SizedBox(
                            height: screenHeight * 0.37,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final card = controller.onFieldP1[index + 5];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onFieldP2[index + 5] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 6}"),
                                        // ),
                                        GestureDetector(
                                          // onTap: () {
                                          //   if (controller.handCards[controller.selectedCardIndex.value] is SpellCardModel) {
                                          //     controller.placeCardonFieldP2(index + 5, context);
                                          //   }
                                          // },
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
                                                ? SpellCardOnBattle(
                                                spellCardModel: card,
                                              animateOnAppear: true,
                                            )
                                                : Center(child: Text("Ô ${index + 6}")),
                                          ),
                                        ),
                                        // if (card is SpellCardModel)
                                        //   Text("${card.name}", style: const TextStyle(fontSize: 12)),
                                      ],
                                    );
                                  }),
                                ),
                                // Hàng trên: chỉ chứa UnitCardModel
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final card = controller.onFieldP1[index];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onFieldP2[index] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 1}"),
                                        // ),
                                        GestureDetector(
                                          // onTap: () {
                                          //   if (controller.handCards[controller.selectedCardIndex.value] is UnitCardModel) {
                                          //     controller.placeCardonFieldP2(index,context);
                                          //   }
                                          // },
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
                                                ? UnitCardOnBattle(
                                                unitCardModel: card,
                                              animateOnAppear: true,
                                            )
                                                : Center(child: Text("Ô ${index + 1}")),
                                          ),
                                        ),
                                        if (card is UnitCardModel)
                                          Column(
                                            children: [
                                              Text("HP: ${card.currentHealthPoints}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: card.currentHealthPoints < card.healthPoints ? Colors.red : card.currentHealthPoints > card.healthPoints ? Colors.green : Colors.grey
                                                  )
                                              ),
                                              Text("ATK: ${card.currentAttackPower}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: card.currentAttackPower < card.attackPower ? Colors.red : card.currentAttackPower > card.attackPower ? Colors.green : Colors.grey
                                                  )
                                              ),
                                            ],
                                          ),
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
              Divider(),
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
                                    final card = controller.onFieldP2[index];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onFieldP2[index] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 1}"),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.handCardsP2[controller.selectedCardIndex.value] is UnitCardModel) {
                                              controller.placeCardOnField(player: Player.player2, fieldIndex: index, context: context);
                                            }
                                          },
                                          onDoubleTap: () {
                                            controller.cardInformation(card as UnitCardModel);
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
                                                ? UnitCardOnBattle(
                                                unitCardModel: card,
                                              animateOnAppear: true,
                                            )
                                                : Center(child: Text("Ô ${index + 1}")),
                                          ),
                                        ),
                                        if (card is UnitCardModel)
                                          Column(
                                            children: [
                                              Text("HP: ${card.currentHealthPoints}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: card.currentHealthPoints < card.healthPoints ? Colors.red : card.currentHealthPoints > card.healthPoints ? Colors.green : Colors.grey
                                                  )
                                              ),
                                              Text("ATK: ${card.currentAttackPower}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: card.currentAttackPower < card.attackPower ? Colors.red : card.currentAttackPower > card.attackPower ? Colors.green : Colors.grey
                                                  )
                                              ),
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
                                    final card = controller.onFieldP2[index + 5];
                                    return Column(
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     controller.onFieldP2[index + 5] = null;
                                        //     controller.update();
                                        //   },
                                        //   child: Text("Delete ${index + 6}"),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.handCardsP2[controller.selectedCardIndex.value] is SpellCardModel) {
                                              controller.placeCardOnField(player: Player.player2, fieldIndex: index + 5, context: context);
                                            }
                                          },
                                          onDoubleTap: () {
                                            controller.cardInformation(card as SpellCardModel);
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
                                                ? SpellCardOnBattle(
                                                spellCardModel: card,
                                              animateOnAppear: true,
                                            )
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
            final handCards = controller.handCardsP2;
            final int cardCount = handCards.length;
            final double totalWidth = (cardCount - 1) * cardOffset + cardWidth;
            return Positioned(
              bottom: 0,
              left: (screenWidth - totalWidth) / 2,
              child: SizedBox(
                  width: totalWidth,
                  height: screenHeight * 0.27,
                  child: Stack(
                    children: List.generate(
                      handCards.length,
                          (index) {
                        final card = handCards[index];
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
                              onDoubleTap: () {
                                controller.cardInformation(card is UnitCardModel ? card : card as SpellCardModel);
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
          }),

          Obx(() => Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              spacing: 16,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: controller.graveCardsP2.isEmpty
                        ? null
                        : Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: cardWidthOnbattle + 64,
                        height: cardWidthOnbattle * (8 / 5) + 64,
                        child: Center(
                            child: controller.graveCardsP2.isEmpty
                                ? Container(
                                width: cardWidthOnbattle + 64,
                                height: cardWidthOnbattle * (8 / 5) + 64,
                                child: Placeholder()
                            )
                                : Container(
                              width: cardWidthOnbattle + 64,
                              height: cardWidthOnbattle * (8 / 5) + 64,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Center(
                                child: Obx(() => Text(
                                  'Grave: ${controller.graveCardsP2.length}',
                                  style: const TextStyle(fontSize: 24, color: Colors.white),
                                )),
                              ),
                            )
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: cardWidthOnbattle + 64,
                  height: cardWidthOnbattle * (8 / 5) + 64,
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped draw card button');
                      controller.drawCard(player: Player.player2);
                    },
                    child: Container(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),),

          Positioned(
            bottom: 16,
            left: 16,
            child: SizedBox(
              width: cardWidthOnbattle + 64,
              height: cardWidthOnbattle * (8 / 5) + 64,
              child: GestureDetector(
                onTap: () {
                  print('Tapped end turn button');
                  controller.endTurn();
                },
                child: Container(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

