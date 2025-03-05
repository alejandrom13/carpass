import 'package:flutter/material.dart';

BottomNavigationBarItem SwipBottomNabvarItem(
    {required Icon icon, context, String? label}) {
  return BottomNavigationBarItem(
    activeIcon: Container(
      child: icon,
    ),
    label: label ?? '',
    icon: Container(
      child: icon,
    ),
  );
}
