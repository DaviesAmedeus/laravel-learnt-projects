
import 'package:davies_flutter/services/api.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_edit.dart';



class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int clicked = 0;
  late Future<List<Category>> futureCategories;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureCategories = apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
          ),
          body: FutureBuilder<List<Category>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Category category = snapshot.data![index];
                      return ListTile(
                        title: Text(category.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return CategoryEdit(category);
                                });
                          },
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print('>>>>>>>>>>>>>${snapshot.data}<<<<<<<<<<<<<<');

                return Text('Something went wrong ${snapshot.error}');
              }

              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
