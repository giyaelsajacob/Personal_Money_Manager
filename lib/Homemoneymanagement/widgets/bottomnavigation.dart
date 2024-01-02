import 'package:flutter/material.dart';

import '../home_screenmoneymanagement.dart';

class MoneyManagementBottomNavigation extends StatelessWidget {
  const MoneyManagementBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:MoneyManagementScreenHome.selectedIndexNotifier,
      builder: (BuildContext, int updatedIndex, Widget?_){
        return BottomNavigationBar(
          selectedItemColor:Colors.red,
          unselectedItemColor:Colors.grey,
          currentIndex:updatedIndex,
          onTap:(newIndex) {
            MoneyManagementScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label:'Transaction'),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category'),
          ],);
      },
    );
  }}
