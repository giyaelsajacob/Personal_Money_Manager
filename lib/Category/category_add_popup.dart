import 'package:demo/modelsformoneyapp/category_model.dart';
import 'package:demo/moneymanagementdbfunctions/categoryfunctions.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  // print("Name -->${_name}");
                  if (_name.isEmpty) {
                    return;
                  }
               //namml name eduth ini namku model create cheyanum
              final _type=selectedCategoryNotifier.value;
               final _category=CategoryModel(
                   id:DateTime.now().millisecondsSinceEpoch.toString(), name: _name, type:_type);

               CategoryDB.instance.insertCategory(_category);
               //instance vilichad singleton ayond
               //ipo aDD category en paranja ORU SCREEN VARILE ATH MAARAN POP KODUKUM
                  Navigator.of(ctx).pop();
                      //ctx use cheyath aa dialog il olla context venom pokan
                }, // ithream chyth kazjinjit nmk add cheyanum add cheyunnath databaseilot.apo ab eduknum
                child: Text('add')),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  RadioButton({
    required this.title,
    required this.type,
  });

  CategoryType? _type;

  // nammalk expense njekumbo expense varanum,athpole tahnne income select cheyumbol income varanumm athin vendi oru variable venom
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // aa return nte kodde ullath arn avide undarne ath listen cheyan vendi ahnu value listenable builder use aakunnath
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            //ith builderil njekumbo varum
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}

//radio button oru value hold cheyan pattum athond ahnu category tpe kodukunnath,group value koduthal aa sanam matram select aai avide kidakkum
