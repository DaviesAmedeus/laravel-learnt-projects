
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api.dart';

class CategoryEdit extends StatefulWidget {


  final Category category;
  final Function categoryCallback;

   CategoryEdit(this.category,this.categoryCallback ,{Key? key}) : super(key : key);

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  // ApiService apiService = ApiService();

  String errorMessage =  '';

  void initState() {
    super.initState();
    categoryNameController.text = widget.category.name;
  }


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

    widget.category.name = categoryNameController.text;
   await  widget.categoryCallback(widget.category);
    Navigator.pop(context);


  }
}
