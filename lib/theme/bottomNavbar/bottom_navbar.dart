import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';

BottomNavigationBar SwipBottomNavbar(
    {required List<BottomNavigationBarItem> items,
    required int currentIndex,
    Function(int)? onTap}) {
  return BottomNavigationBar(
    elevation: 1,
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    currentIndex: currentIndex,
    onTap: onTap,
    selectedItemColor: theme.primaryColor,
    items: items,
  );
}
