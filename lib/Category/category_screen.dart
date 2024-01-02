import 'package:demo/Category/expense_categorylist.dart';
import 'package:demo/Category/income_categorylist.dart';
//import 'package:demo/moneymanagementdbfunctions'/categoryfunctions.dart';/categoryfunctions.dart';/categoryfunctions.dart';/categoryfunctions.dart';/categoryfunctions.dart';
import 'package:flutter/material.dart';
import '../moneymanagementdbfunctions/categoryfunctions.dart';
//ivde nammlk tapbar use aakunnd.so nammalk kurach animatioum use aakunnallath kond stateful

class MoneyManagementScreenCategory extends StatefulWidget {
  const MoneyManagementScreenCategory({Key? key}) : super(key: key);

  @override
  _MoneyManagementScreenCategoryState createState() =>
      _MoneyManagementScreenCategoryState();
}

class _MoneyManagementScreenCategoryState
    extends State<MoneyManagementScreenCategory>
    with SingleTickerProviderStateMixin //ith add akki
 {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

  //get categories in pakaram namlk refresh UI kodukaam
    //category db k vedni oru object cfeate aakuaka,meanse namalk income vilikumbo income vranum,rxpense vilikumbo sexpense taranum orumich get chytit sepertae aait display cheyikanaum
    CategoryDB().refreshUI();

//overrisdil koduthath ivde kodutthh

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TabBar(
          labelColor:Colors.red,
          unselectedLabelColor:Colors.grey,
          controller: _tabController,
          tabs: const [
            Tab(text: 'INCOME'),
            Tab(text: 'EXPENSE'),
          ],
        ),
        Expanded(  //baacki full tabbarview edukan vendi tabbarview ine expanded vech wrap chyth
          child: TabBarView(
              controller: _tabController,
              children:const [
               IncomeCategoryList(),
                ExpenseCategoryList()
              ]),
        )
      ],
    );
  }
}


