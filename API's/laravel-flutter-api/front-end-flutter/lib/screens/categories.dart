import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_add.dart';
import '../widgets/category_edit.dart';
import 'package:davies_flutter/providers/category_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int clicked = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Category category = categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return CategoryEdit(
                                category, provider.updateCategory);
                          });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                  onPressed: () => deleteCategory(
                                      provider.deleteCategory, category),
                                  child: Text('Confirm')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('cancel'))
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CategoryAdd(provider.addCategory);
              });
        },
        child: Icon(Icons.add)),
      ),
    );
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    Navigator.pop(context);
  }
}
