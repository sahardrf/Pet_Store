import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:http/http.dart' as http;
import 'package:dbcrypt/dbcrypt.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  static const String _title = 'Pet Store';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Dynamic Game'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
        body: const MyStatefulWidget());
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
    return  GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      child: Padding(
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text('Login'),
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        SignInFailedDialog(
                            context, "Please enter your username and password.");
                      } else {
                        login(nameController.text, passwordController.text);
                      }
    
                      // print(nameController.text);
                      // print(passwordController.text);
                    },
                  )),
            ],
          )),
    );
  }

  login(username, password) async {
    var queryParams = {
      'username': username,
    };
    var URL = 'https://api.training.testifi.io/api/v3/user/';
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = URL + username;
    // Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.get(Uri.parse(requestUrl));
    print(requestUrl);
    if (response.statusCode == 200) {
      DBCrypt dBCrypt = DBCrypt();
      var res = json.decode(response.body);
      var hashedPwd = res['password'];

      if (dBCrypt.checkpw(password, hashedPwd)) {
        /// send username and password to flutter_secure_storage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PetStoreHomePage(
              LoggedIn: true,
            ),
          ),
          (route) => false,
        );
      } else {
        SignInFailedDialog(context, "Username or Password are wrong.");
      }
    } else {
      SignInFailedDialog(context, "Username is not registered.");
    }
  }

  SignInFailedDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sign In Failed"),
      content: Text(message),
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
