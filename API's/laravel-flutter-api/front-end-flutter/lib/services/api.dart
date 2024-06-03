import '../models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  late String token;

  ApiService(String token){
    this.token = token;
  }
  final String baseUrl = 'http://192.168.1.173:8000/api/';

  ///Api call to fetch all category on database
  Future<List<Category>> fetchCategories() async {

    http.Response response = await http.get(Uri.parse('${baseUrl}categories'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'

        });

    List categories = jsonDecode(response.body);

    print('>>>>>>>RESPONSE>>>>${response.body}');

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  ///Api call to add a category on database
  Future<Category> addCategory(String name) async{
    String uri = '${baseUrl}categories';

    http.Response response= await http.post(Uri.parse(uri),  headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    },
        body: jsonEncode({'name': name})
    );

    if(response.statusCode != 201){
      print('>>>>ERROR STATUS CODE ${response.statusCode}');
      print('>>>>ERROR whole${response.body}');
      throw Exception('Error happened on create');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  ///Api call to update a category on database
  Future<Category> updateCategory(Category category) async{
    String uri = '${baseUrl}categories/${category.id.toString()}';

   http.Response response= await http.put(Uri.parse(uri),  headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
     HttpHeaders.authorizationHeader: 'Bearer $token'

   },
        body: jsonEncode({'name': category.name})
    );

   if(response.statusCode != 200){
      throw Exception('Error happened on update');
   }

    return Category.fromJson(jsonDecode(response.body));
  }

  ///Api call to delete a category on database
  Future<void> deleteCategory(id) async{
    String uri = '${baseUrl}categories/${id.toString()}';

    http.Response response= await http.delete(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'

    });

    if(response.statusCode != 204){
      print('>>>>ERROR STATUS CODE ${response.statusCode}');
      throw Exception('Error happened on delete');
    }
  }

  ///Api call to register a new user of the system
  Future<String> register(String name, String email, String password,
      String confirmPassword, String deviceName) async{
    String uri = '${baseUrl}auth/register';

    http.Response response= await http.post(Uri.parse(uri),  headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password' : password,
          'password_confirmation' : confirmPassword,
          'device_name' :deviceName
        })
    );

    print('>>>>STATUS CODE>> ${response.statusCode}');

    if(response.statusCode==422){
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      print('>>>>STATUS CODE>> ${body['errors']}');
      String errorMessage ='';
      errors.forEach((key, value) {
        value.forEach((element){
          errorMessage += '$element\n';
        });
      });
      throw Exception(errorMessage);
    }
    return response.body;
  }


  ///Api call to login user of the system
  Future<String> login( String email, String password, String deviceName) async{
    String uri = '${baseUrl}auth/login';

    http.Response response= await http.post(Uri.parse(uri),  headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    },
        body: jsonEncode({
          'email': email,
          'password' : password,
          'device_name' :deviceName
        })
    );

    print('>>>>STATUS CODE>> ${response.statusCode}');

    if(response.statusCode==422){
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      print('>>>>STATUS CODE>> ${body['errors']}');
      String errorMessage ='';

      errors.forEach((key, value) {
        value.forEach((element){
          errorMessage += '$element\n';
        });
      });
      throw Exception(errorMessage);
    }
    return response.body;
  }


}