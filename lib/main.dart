import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pet_store/Search.dart';
import 'package:pet_store/widgets/get_pet_cards.dart';
import 'package:pet_store/widgets/get_pet_listview.dart';
import 'package:pet_store/widgets/get_store_data.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:pet_store/widgets/login.dart';

void main() => runApp(HomePage());
 

class HomePage extends StatelessWidget {
  // bool? LoggedIn;
 const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Store',
      home: DoubleBack(
        child: PetStoreHomePage(),
        message: "Back press again to Exit App",
      )
    );
  }
}

class PetStoreHomePage extends StatefulWidget {
  // const PetStoreHomePage({ Key? key }) : super(key: key);
  // final String url = '';
  final String? selectedURL;
  final bool? LoggedIn;
  PetStoreHomePage({
    this.selectedURL,
    this.LoggedIn = false
  });

  @override
  _PetStoreHomePageState createState() => _PetStoreHomePageState();
}

class _PetStoreHomePageState extends State<PetStoreHomePage> {
  late List<bool> isSelected;


  @override
  void initState() {
      isSelected = [true, false];
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('HOME PAGE');
    print(widget.selectedURL);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Pets'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed:(){
                Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => const Search(),
                                            ),
                                            (route) => false,
                                          );
            },
          ),
        ],
      ),
      body: DoubleBack(
        message: "Back press again to Exit App",
        child: Center(child: Column(children: [
          const Text("   "),
          Align(
            alignment: Alignment.topCenter,
            child: ToggleButtons(
              color: Color.fromARGB(255, 99, 98, 98),
              borderColor: Color.fromARGB(255, 99, 98, 98),
              fillColor: Color.fromARGB(255, 99, 98, 98),
              borderWidth: 1,
              selectedBorderColor: Color.fromARGB(255, 99, 98, 98),
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              children: const <Widget>[
                  Icon(Icons.format_list_bulleted),
                  Icon(Icons.featured_play_list),
        ], 
        isSelected: isSelected,
        onPressed: (int index){
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          },
          );
        },
        ),
        ),
        Expanded(child: (isSelected[0] == true)? Get_Pet_List(selectedURL: widget.selectedURL): Get_Pet_Cards(selectedURL: widget.selectedURL)),
          ],
          ),
      ),
    ), 
    drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Center(child: ListTile(
                leading: Icon(Icons.portrait_rounded, size:80, color: Colors.white,),
                title: Text('Pet Store', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
                ),
                ),  //USER Profile if log in
            ),
            ListTile(
              leading: (widget.LoggedIn == true)? Icon(Icons.logout, color: Colors.black,):Icon(Icons.login, color: Colors.black,),
              title: (widget.LoggedIn == true)? Text('Log out'): Text('Login'), //change to logout if logged in
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                if (widget.LoggedIn == false){
                    Navigator.pushAndRemoveUntil(context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => const login(),
                                                ),
                                                (route) => false,
                                              );
              }
               else if(widget.LoggedIn == true){
                    Navigator.pushAndRemoveUntil(context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => PetStoreHomePage(LoggedIn: false,),
                                                ),
                                                (route) => false,
                                              );

                }
              } // OnTap
            ),
            ExpansionTile(
            leading: const Icon(Icons.pets, color: Colors.black),
            title: const Text('Pet'),
            children: <Widget>[
                                // ListTile(leading: Icon(Icons.search),title:Text("Find Pet")),
                                TextButton(child: const ListTile(leading: Icon(Icons.add),title:Text("Add a new Pet")), onPressed: () => Navigator.pop(context),),
                                // ListTile(leading: Icon(Icons.add),title:Text("Add a new Pet"))
                              ],
              // onTap: () {
              //   // Update the state of the app
              //   // ...
              //   // Then close the drawer
              //   Navigator.pop(context);
              // },
            ),
            ExpansionTile(
            leading: const Icon(Icons.local_grocery_store, color: Colors.black),
            title: const Text('Store'),
            children: <Widget>[
                                TextButton(child: const ListTile(leading: Icon(Icons.attach_money),title:Text("Place Order")), onPressed: () => Navigator.pop(context),),
                                TextButton(child: const ListTile(leading: Icon(Icons.search),title:Text("Find an Order")), onPressed: () => Navigator.pop(context),),
                                ],
            )  
          ],
        ),
      ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add your onPressed code here!
//         },
//         backgroundColor: Colors.indigo,
//         child: new IconTheme(
//     data: new IconThemeData(
//         color: Colors.white), 
//     child: new Icon(Icons.add),
// ),
//       ),
    );
    
  }
}

