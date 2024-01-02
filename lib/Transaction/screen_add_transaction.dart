//nammlktransaction add cheyan oru page venom ath ahnuini undakan pone

import 'package:demo/Transaction/transaction_db.dart';
import 'package:demo/Transaction/transaction_model.dart';
import 'package:demo/modelsformoneyapp/category_model.dart';
import 'package:demo/moneymanagementdbfunctions/categoryfunctions.dart';
import 'package:flutter/material.dart';

//route il kodukan namuk oru page kodukanam athin ahnuu
class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';

  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  //nammulk in selectedcategory type default aai set cheyanum..
  // athond namk init state kodukanaum,aadyum koduthal ath otta vataome execute aaku,builder pole rebuild aakilla

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  /*transaction are used in
  Purpose
  Date
  Amount
  Income/Expense
  Category type
  * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //purpose
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),

            //amount

            TextFormField(
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),

            //calender
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDate.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate!.toString()),
            ),
            //category

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        //groupvalue intem radiode value um match aayal maatarme aa round avide varu,group value means user select chytha value
                        onChanged: (newValue) {
                          //initially selected category income ahnuu ini click cheyumbol ath maarnum athin ulla command ivde kodukanum
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                          });
                        }),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    Text('Expense'),
                  ],
                ),
              ],
            ),

            //category type

            DropdownButton(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    //dropdown il namuk nammuk ororn und,so nammal ipo income njeki,athil salary click akiyath save akan vendi ahnuu dropdown il on tap kodukanam
                    onTap: (){
                      _selectedCategoryModel=e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                }),
            //submit
            ElevatedButton(onPressed: () {
              addTransaction();
            }, child: Text('Submit'))
          ], //oru category de list ithil und,incomeCategoryListListener.value,ipo ee list of category il ninn oru list of drop down um und ath tammil connect aakn,oru list il nin matte list ine connect aakannamuk map enna function use aakm...nammlde kail ulla list category model ilnte aahnuu apo namulk dropdown nte list venom,so namml ithine map cheyum
          //nammal ivde items il CategoryDB koduthath database ile value ahnu list chyande
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
  if(_purposeText.isEmpty){
    return;
  }
  if(_amountText.isEmpty){
    return;
  }
  //selecteddate und
  //selectedcategorytype und
    if(_categoryID==null){
      return;
    }
    if(_selectedDate == null){
      return;
    }
    if(_selectedCategoryModel==null)
      {
        return;
      }
    //ipo amount stringil ahnu athine double aakanum
    final _paresedAmount=double.tryParse(_amountText);
    if(_paresedAmount==null){
      return;
    }
    final _model= TransactionModel(
        purpose: _purposeText,
        amount: _paresedAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategoryModel!,
        //nammlk ivde oru category ID und ath vech nammulk CategoryModel create aakanum.
    );
  await TransactionDB.instance.addTransaction(_model);
  Navigator.of(context).pop();
  TransactionDB.instance.refresh();
  }

}
