import 'package:demo/Category/category_add_popup.dart';
import 'package:demo/Homemoneymanagement/widgets/bottomnavigation.dart';
import 'package:demo/Transaction/screen_add_transaction.dart';
import 'package:demo/Transaction/transaction_screen.dart';
import 'package:demo/modelsformoneyapp/category_model.dart';
import 'package:flutter/material.dart';
import '../Category/category_screen.dart';
import '../moneymanagementdbfunctions/categoryfunctions.dart';

class MoneyManagementScreenHome extends StatelessWidget {
  MoneyManagementScreenHome({super.key});

  //nmmalk ini bottom navigation ile athil onnel click cheyumbol matethilott switch cheyanum ath ivde static use cheyanum
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    MoneyManagementScreenTransaction(),
    MoneyManagementScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('MY MONEY MANAGER')),
        ),
        bottomNavigationBar: const MoneyManagementBottomNavigation(),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedIndexNotifier.value == 0) {
              print('Add Transactions');
              Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
            } else {
              print('Add Categories');
              showCategoryAddPopup(context);
          //     final _sample = CategoryModel(
          //         id: DateTime.now().millisecondsSinceEpoch.toString(),
          //         name: 'Travel',
          //         type: CategoryType.expense);
          //
          //   //insert aakunndo en noakan vendi aa sample create chytheth
          //
          //     CategoryDB().insertCategory(_sample);
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ));
  }
}
