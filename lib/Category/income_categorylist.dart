import 'package:flutter/material.dart';
import '../modelsformoneyapp/category_model.dart';
import '../moneymanagementdbfunctions/categoryfunctions.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener, builder: (BuildContext ctx, List<CategoryModel>newLIst, Widget?_){
      return ListView.separated(
          itemBuilder: (ctx, index) {
            //ipo 10 value ond,ath ooro vattavum item builder edukanam athinanu final
            final category=newLIst[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing:IconButton(onPressed: (){
                  CategoryDB.instance.deleteCategory(category.id);
                }, icon: const Icon(Icons.delete,color:Colors.red,)),
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

