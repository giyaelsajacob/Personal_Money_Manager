import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../modelsformoneyapp/category_model.dart';

const CATEGORY_DB_NAME = 'category-database'; //nammal oru constant undakanaum

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories(); //displaycheyan
  Future<void> insertCategory(CategoryModel value);
  Future<void>deleteCategory(String catergoryID);
}

class CategoryDB implements CategoryDbFunctions {
  //ipol databaseilot values add akumbol ath automatically update/refresh  aakan vendii screen
// nammal adutahath oru single ton create cheyan povaanu so athin vendi nammal category db yude oru object ine call cheyum ,anit aa object inte ulil ulla oru variable ine call cheyumbol aa object ine kodukum
CategoryDB._internal();
static CategoryDB instance=CategoryDB._internal();
// instance ine vilikumbol namlk internal en paranja object venom kittan,so avide oru object matram oll en confirm aakan vendi namml ivde factory use cheyunnd.
factory CategoryDB(){
  return instance;
}
  ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    //ee getcategories vilikumbol income um expense um orumichaa kittunnath
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

//categorydb njekumbo oveeride

//refresh aakan ulla function
  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear(); //to avoid duplication
    //get all categories enn parayumbol athil income um expenseum orupole keri varum..apo athine seperate seperate aakan vendii adutha oru function ezhutanaum
    await Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListener.value.add(category);
      } else {
        expenseCategoryListListener.value.add(category);
      }
    });

//nammalk data k add akiyen shesham notify cheyanum athin ahn ini cheyunnath

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String catergoryID)async{
    //nextbox open aaknum
    final _categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   await _categoryDB.delete(catergoryID);
   refreshUI();
   //ini namuk ath njekumbol pokanum so ath button clickil oru action kodukam..
  }
}

//for each il elements ond athil all categories il touch cheyumbol namk elements il njekan olla values kittum
