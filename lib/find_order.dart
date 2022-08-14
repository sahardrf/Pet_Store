import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Find_Order extends StatefulWidget {
  const Find_Order({Key? key}) : super(key: key);

  @override
  State<Find_Order> createState() => _Find_OrderState();
}

class _Find_OrderState extends State<Find_Order> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Find an Order'),
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PetStoreHomePage(LoggedIn: true),
                ),
                (route) => false,
              );
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: mycontroller,
                  decoration: const InputDecoration(
                    labelText: 'Enter Order ID',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  // Only numbers can be entered
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.indigo,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                  onPressed: () async {
                    var order_id = mycontroller.text;
                    var url =
                        "https://api.training.testifi.io/api/v3/store/order/" + order_id;
                    // var response = http.get(Uri.parse(url));
                    final response = await http.get(Uri.parse(url),
                        headers: {"Content-type": "application/json"});
                        print(url);
                        print(response.statusCode);
                    if (response.statusCode == 200) {
                      Toast.show("Order Found.", context);
                    } else {
                      Toast.show("ERROR! Finding order failed.", context);
                    }
                  }),
            ],
          ),
        ));
  }
}
