import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_store/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:dbcrypt/dbcrypt.dart';

 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  static const String _title = 'Pet Store';
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                width: 20,
                child: Image.asset('assets/logo.jpg'),
                
                ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if(nameController.text.isEmpty || passwordController.text.isEmpty){
                      emptyFieldsDialog(context);
                    }
                    else{
                      login(nameController.text,passwordController.text);
                      
                    }
                    
                    // print(nameController.text);
                    // print(passwordController.text);
                  },
                )
            ),
          ],
        ));
  }

login (username, password) async {
  var queryParams = {
    'username': username,
    };
  var URL = 'https://api.training.testifi.io/api/v3/user/';
  String queryString = Uri(queryParameters: queryParams).query;
  var requestUrl = URL + username;
  // Map<String, String> headers = {"Content-type": "application/json"};
  final response = await http.get(Uri.parse(requestUrl));
  print(requestUrl);
  if (response.statusCode == 200){

    DBCrypt dBCrypt = DBCrypt();
    var res = json.decode(response.body);
    var hashedPwd = res['password'];
    // dBCrypt.checkpw(password, hashedPwd);

    if (dBCrypt.checkpw(password, hashedPwd)){
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
    else{
      signInFailedError(context);
    }
    }
    else{
      userNotFoundDialog(context);
    }
    
  }
//   else{
//     userNotFoundDialog(context);
//   }

// }

// get_user_info (username, password) async {
//   var queryParams = {
//     'username': username,
//     'password': password,
//     };
//   var URL = 'https://api.training.testifi.io/api/v3/user/login';
//   String queryString = Uri(queryParameters: queryParams).query;
//   var requestUrl = URL + '?' + queryString;
//   Map<String, String> headers = {"Content-type": "application/json"};
//   final response = await http.get(Uri.parse(requestUrl), headers: headers);
//   print(requestUrl);
//   print(response);
//   if (response.statusCode == 200){
//     Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
//   }
//   else{
//     signInFailedError(context);
//   }

// }

signInFailedError(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OKg"),
    onPressed: () => Navigator.pop(context) ,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sign In Failed"),
    content: Text("Username or Password are wrong."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
emptyFieldsDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context) ,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Empty Fields"),
    content: Text("Please enter your username and password."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

userNotFoundDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context) ,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sign In Failed"),
    content: Text("Username is not registered."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}
