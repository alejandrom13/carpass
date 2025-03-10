import 'package:carpass/features/profile/profile_page.dart';
import 'package:carpass/features/report/vehicle-list/vehicle_list.dart';
import 'package:carpass/theme/CustomIcons_icons.dart';
import 'package:carpass/theme/bottomNavbar/bottom_navbar.dart';
import 'package:carpass/theme/bottomNavbar/swip_bottom_nabvar_item.dart';
import 'package:flutter/material.dart';

class SwipBottomNavbarComponent extends StatefulWidget {
  const SwipBottomNavbarComponent({super.key});

  @override
  State<SwipBottomNavbarComponent> createState() => _SwipBottomNavbarState();
}

class _SwipBottomNavbarState extends State<SwipBottomNavbarComponent> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _screens(selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const VehicleList();
      case 1:
        return ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: _screens(_selectedIndex),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: SwipBottomNavbar(
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: <BottomNavigationBarItem>[
                SwipBottomNabvarItem(
                    label: 'Inicio',
                    icon: const Icon(
                      CustomIcons.home,
                      size: 22,
                    )),
                SwipBottomNabvarItem(
                    label: 'Cuenta',
                    icon: const Icon(
                      Icons.person,
                      size: 22,
                    )),
              ]),
        ));
  }
}
