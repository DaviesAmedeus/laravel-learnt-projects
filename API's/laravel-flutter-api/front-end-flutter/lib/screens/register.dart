import 'package:davies_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
// import 'package:device_info/device_info.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String errorMessage = '';
  String deviceName = 'Infinix636';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getDeviceName();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                        controller: nameController,
                        onChanged: (text) => setState(() => errorMessage = ''),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter name';
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
                        ),
                      ),
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
                      TextFormField(
                        controller: passwordConfirmController,
                        onChanged: (text) => setState(() => errorMessage = ''),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter confirm password';
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => submit(),
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('<- Back to Login?'),
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
      await provider.register(
          nameController.text,
          emailController.text,
          passwordController.text,
          passwordConfirmController.text,
          deviceName);
        Navigator.pop(context);
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }

  // Future<void> getDeviceName() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       setState(() {
  //         deviceName = build.model;
  //       });
  //     } else if (Platform.isIOS) {
  //       var build = await deviceInfoPlugin.iosInfo;
  //       setState(() {
  //         deviceName = build.model;
  //       });
  //     }
  //   } on PlatformException {
  //     setState(() {
  //       deviceName = 'Failed to get platform version';
  //     });
  //   }
  // }
}
