import 'package:demo/Transaction/transaction_db.dart';
import 'package:demo/Transaction/transaction_model.dart';
import 'package:demo/modelsformoneyapp/category_model.dart';
import 'package:demo/moneymanagementdbfunctions/categoryfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MoneyManagementScreenTransaction extends StatelessWidget {
  const MoneyManagementScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    //refresh ui cheyumbo athath category add aakum
    CategoryDB.instance
        .refreshUI(); // apo database il nin data fetch cheyum,ini notifier vech rebuild akanum
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            //nammlde values varunnath item builder il ahnnu
            // first ilathe value edukanum,oror index vech ahnu value varunnath
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key:Key(_value.id!),
                  startActionPane:ActionPane(
                      motion: ScrollMotion(),
                      children:[
                    SlidableAction(
                      onPressed: (ctx){
                        print("delete press");
                      TransactionDB.instance.deleteTransaction(_value.id!);
                    },icon: Icons.delete,
                      label: 'Delete',)
                  ]),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    //list tile nmml card vech wrap chythh
                    leading: CircleAvatar(
                      radius: 50,
                      child: Center(child: Text(parseDate(_value.date))),
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.pink
                          : Colors.deepPurple,
                    ),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text(_value.category.name),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length,
          );
        });
  }

  //date parse cheyann vendi oru function ..kodukunna date kittan
  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
    // return '${date.day}\n${date.month}';
  }
}
