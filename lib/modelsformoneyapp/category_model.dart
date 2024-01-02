//basically ee model undakiyathh nammuk databaseil value add akan vendi aa

import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId:2)
enum CategoryType {
  @HiveField(0)
  income,
   @HiveField(1)
  expense,
}
//category model hive il lek read and write cheyuksa sahnu next task
@HiveType(typeId:1)

class CategoryModel {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  //mukakil undakiyente constructor ahnu namml thazhe create cheyunnath

  CategoryModel(
      {required this.id,required this.name, required this.type, this.isDeleted = false});
@override
  String toString() {
  return '{$name   $type}';

  }

}


