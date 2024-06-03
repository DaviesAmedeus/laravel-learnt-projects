
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api.dart';

class CategoryAdd extends StatefulWidget {



  final Function categoryCallback;

  CategoryAdd(this.categoryCallback ,{Key? key}) : super(key : key);

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  // ApiService apiService = ApiService();

  String errorMessage =  '';




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                onChanged: (text)=> setState(() =>errorMessage = ''),
                controller: categoryNameController,
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Enter category name';
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category name'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => saveCategory(),
                  child: const Text('Save'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            Text(errorMessage, style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }

  Future saveCategory() async {
    final form = _formKey.currentState;
    if(!form!.validate()){
      return;
    }

    await  widget.categoryCallback(categoryNameController.text);
    Navigator.pop(context);


  }
}
