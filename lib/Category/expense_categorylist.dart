import 'package:demo/moneymanagementdbfunctions/categoryfunctions.dart';
import 'package:flutter/material.dart';

import '../modelsformoneyapp/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    //ipo nammal ivde value listenable builder vilikunnath nerthe nammal cut chyth vecehe avide paste aakanum
  //  connect cheyunna paripaady ahnu ith,list view il connect cheyan
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener, builder: (BuildContext ctx, List<CategoryModel>newLIst, Widget?_){
      return ListView.separated(
          itemBuilder: (ctx, index) {
            //ipo 10 value ond,ath ooro vattavum item builder edukanam athinanu final
            final category=newLIst[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing:IconButton(onPressed: (){
                  CategoryDB.instance.deleteCategory(category.id);
                }, icon:const Icon(Icons.delete,color:Colors.red,)),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(height: 10,);
          },
          itemCount: newLIst.length);
    }
      );
  }
}
