import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nexus_versus/app/modules/card_list/views/card_list_view.dart';
import 'package:nexus_versus/app/modules/debug_build/views/debug_build_view.dart';
import 'package:nexus_versus/app/modules/home/views/home_view.dart';

import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexus Versus')
      ),
      body: Row(
        children: [
          Container(
              width: 80,
              color: Theme.of(context).colorScheme.surfaceContainer, // Light gray background
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _NavItem(
                    icon: Icons.home,
                    label: 'Home',
                    isSelected: controller.currentIndex.value == 0,
                    onTap: () => controller.onTabChange(0),
                  ),
                  _NavItem(
                    icon: Icons.collections_bookmark_rounded,
                    label: 'Collection',
                    isSelected: controller.currentIndex.value == 1,
                    onTap: () => controller.onTabChange(1),
                  ),
                  _NavItem(
                    icon: Icons.bug_report,
                    label: 'Debug',
                    isSelected: controller.currentIndex.value == 2,
                    onTap: () => controller.onTabChange(2),
                  ),
                ],
              ),
              )
          ),

          // Main content
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                HomeView(),
                CardListView(),
                DebugBuildView()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
