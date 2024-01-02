
//PERSONAL MONEY MANAGEMENT APP


import 'package:demo/modelsformoneyapp/category_model.dart';
import 'package:demo/moneymanagementdbfunctions/categoryfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'Homemoneymanagement/home_screenmoneymanagement.dart';
import 'Transaction/screen_add_transaction.dart';
import 'Transaction/screen_add_transaction.dart';
import 'Transaction/transaction_model.dart';



Future<void> main() async {
  final obj1 = CategoryDB();
  final obj2 = CategoryDB();
  // print('Objects comparing');
  // print(obj1==obj2);

  //ela pluggins like type id registeres aahno en noakan vendi

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: MoneyManagementScreenHome(),
      debugShowCheckedModeBanner:false,
      //namlk plus button njekumbol new oru page ilot ponum,so namuk route kodukanam
      routes: {
        ScreenaddTransaction.routeName:(ctx)=>const ScreenaddTransaction(),
      },
    );
  }
}
