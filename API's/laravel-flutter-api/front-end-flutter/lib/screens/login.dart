import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  String deviceName = 'Infinix636';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          onChanged: (text) => setState(() => errorMessage = ''),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          onChanged: (text) => setState(() => errorMessage = ''),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: ()  => submit(),
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 36)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text('Register new user?'),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    final AuthProvider provider =
    Provider.of<AuthProvider>(context, listen: false);
    try {
    await provider.login(
          emailController.text,
          passwordController.text,
          deviceName);

    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }
}
