import 'package:get/get.dart';

import '../modules/battle/bindings/battle_binding.dart';
import '../modules/battle/views/battle_view.dart';
import '../modules/card_list/bindings/card_list_binding.dart';
import '../modules/card_list/views/card_list_view.dart';
import '../modules/debug_build/bindings/debug_build_binding.dart';
import '../modules/debug_build/views/debug_build_view.dart';
import '../modules/deck/bindings/deck_binding.dart';
import '../modules/deck/views/deck_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LAYOUT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DEBUG_BUILD,
      page: () => const DebugBuildView(),
      binding: DebugBuildBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => const LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: _Paths.CARD_LIST,
      page: () => const CardListView(),
      binding: CardListBinding(),
    ),
    GetPage(
      name: _Paths.DECK,
      page: () => const DeckView(),
      binding: DeckBinding(),
    ),
    GetPage(
      name: _Paths.BATTLE,
      page: () => const BattleView(),
      binding: BattleBinding(),
    ),
  ];
}
