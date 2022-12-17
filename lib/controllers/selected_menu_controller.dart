import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarMenuItem {
  static const dashboard = 0;
  static const settings = 1;
  static const addApp = 2;
}

//Returns [MenuItem] for the selected sidebar item
final selectedMenuProvider = StateProvider<int>((ref) {
  return SidebarMenuItem.dashboard;
});
