//database ilolt add aaakan vendiii
//TRANSACTION_DB_NAME aahnu databasename

import 'package:demo/Transaction/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);

//Future<void>addTransaction(CategoryModel obj) future aai kodutath write cheyan kurach time edukum athond
  Future<List<TransactionModel>> getAllTransactions();

//slidable buttonil delete cheyumbol ulla butn il kodukan ulla action.void il ahnu kodukunath because onum return cheyunila
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  //single ton
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

// namlk return matrm chytha pora namlk ui il display aakanumm athin vendii notifier kodukanam
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    //openbox il open aakandath transaction model ahnuu
    //  open box cheyumbol _db return cheyum ath oru future function ahnu
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
    // namlk return matrm chytha pora namlk ui il display aakanumm athin vendii notifier kodukanam
  }

  @override
  Future<void> deleteTransaction(String id) async {
   // print('inside delete transaction');
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   // print("db -->${_db.name}");
   // print("id ${id}");
    await _db.delete(id);
    //print(_db.containsKey(id));
    refresh();
  }
}
