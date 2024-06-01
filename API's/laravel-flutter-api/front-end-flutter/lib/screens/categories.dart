import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int clicked = 0;
  late Future<List<Category>> futureCategories;
  final _formKey = GlobalKey<FormState>();
  late  Category selectedCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    String emulator = 'http://10.0.2.2:8000/api/categories';
    String mobile = 'http://192.168.1.173:8000/api/categories';
    http.Response response = await http.get(Uri.parse(mobile));

    print('>>>>>>>>>>>>>${response.statusCode}');
    print('>>>>>>>>>>>>>${response.body}');

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async{
    final form = _formKey.currentState;

    if(!form!.validate()){
      return;
    }

    String uri = 'http://192.168.1.173:8000/api/categories/' + selectedCategory.id.toString();
    await http.put(Uri.parse(uri),  headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    },
      body: jsonEncode({'name': categoryNameController.text})
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
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
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          selectedCategory = category;
                          categoryNameController.text =category.name;
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: categoryNameController,
                                          validator: (String? value){
                                            if(value!.isEmpty){
                                              return 'Enter category name';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Category name'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () => saveCategory(),
                                          child: Text('Save'),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              print('>>>>>>>>>>>>>${snapshot.data}<<<<<<<<<<<<<<');

              return Text('Something went wrong ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ));
  }
}
