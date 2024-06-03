
import 'package:davies_flutter/services/api.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier{
  bool isAuthenticated = false;
  late String token;
  ApiService apiService = ApiService('');

  AuthProvider();

  Future<void> register(String name, String email, String password,
      String confirmPassword, String deviceName) async{

       token  = await apiService.register(name, email, password,
          confirmPassword, deviceName);
      print('>>>>>>>>>>>>>>TOKEN $token');
      isAuthenticated = true;
      notifyListeners();



  }


  Future<void> login(String email, String password, String deviceName) async{

  token  = await apiService.login(email, password, deviceName);
    print('>>>>>>>>>>>>>>TOKEN $token');
    isAuthenticated = true;
    notifyListeners();



  }



}