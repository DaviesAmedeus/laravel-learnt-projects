
import 'package:davies_flutter/providers/auth_provider.dart';
import 'package:davies_flutter/services/api.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier{
  List<Category> categories = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  CategoryProvider(AuthProvider authProvider){
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);
    init();
  }

  Future init() async{
    categories = await apiService.fetchCategories();
    notifyListeners();
  }

  Future addCategory(String name) async{
    try{
      Category addedCategory = await apiService.addCategory(name);
      categories.add(addedCategory);

      notifyListeners();
    }catch(Exception){
      print(Exception);
    }
  }

  Future updateCategory(Category category) async{
    try{
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;
      notifyListeners();
    }catch(Exception){
      print(Exception);
    }
  }

  Future deleteCategory(Category category) async{
    try{
       await apiService.deleteCategory(category.id);
       categories.remove(category);
      notifyListeners();
    }catch(Exception){
      print(Exception);
    }
  }

}