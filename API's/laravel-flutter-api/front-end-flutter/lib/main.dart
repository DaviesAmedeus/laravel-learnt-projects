import 'package:davies_flutter/providers/auth_provider.dart';
import 'package:davies_flutter/screens/categories.dart';
import 'package:davies_flutter/screens/home.dart';
import 'package:davies_flutter/screens/login.dart';
import 'package:davies_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:davies_flutter/providers/category_provider.dart';
import 'package:provider/provider.dart';

import 'models/category.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, authProvider, child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<CategoryProvider>(
                create: (context)=>CategoryProvider(authProvider)),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Welcome to Flutter',

            routes: {
              '/': (context){
                final authProvider = Provider.of<AuthProvider>(context);
                if(authProvider.isAuthenticated){
                  return Categories();
                }else{
                  return Login();
                }

              },
              '/login': (context) => Login(),
              '/register': (context) => Register(),
              '/categories': (context) => Categories(),
            },
          ),
        );
      })
    );
  }
}
