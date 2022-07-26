import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/AddPet.dart';
import 'package:pet_store/guess_game.dart';
import 'package:pet_store/Search.dart';
import 'package:pet_store/presentation/my_flutter_app_icons.dart';
import 'package:pet_store/widgets/get_pet_cards.dart';
import 'package:pet_store/widgets/get_pet_listview.dart';
import 'package:pet_store/widgets/get_store_data.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:pet_store/widgets/login.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  // bool? LoggedIn;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pet Store',
        home: DoubleBack(
          child: PetStoreHomePage(),
          message: "Back press again to Exit App",
        ));
  }
}

class PetStoreHomePage extends StatefulWidget {
  // const PetStoreHomePage({ Key? key }) : super(key: key);
  // final String url = '';
  final String? selectedURL;
  final bool? LoggedIn;
  PetStoreHomePage({this.selectedURL, this.LoggedIn = false});

  @override
  _PetStoreHomePageState createState() => _PetStoreHomePageState();
}

class _PetStoreHomePageState extends State<PetStoreHomePage> {
  late List<bool> isSelected;
  bool? isCollapsed;
  bool isDoubled = false;
  bool isLongPressed = false;

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
        title: const Text('Pets'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Search(),
                ),
              );
            },
          ),
        ],
      ),
      body: DoubleBack(
        message: "Back press again to Exit App",
        child: Center(
          child: Column(
            children: [
              const Text("   "),
              Align(
                alignment: Alignment.topCenter,
                child: ToggleButtons(
                  color: const Color.fromARGB(255, 99, 98, 98),
                  borderColor: const Color.fromARGB(255, 99, 98, 98),
                  fillColor: const Color.fromARGB(255, 99, 98, 98),
                  borderWidth: 1,
                  selectedBorderColor: const Color.fromARGB(255, 99, 98, 98),
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  children: const <Widget>[
                    Icon(Icons.format_list_bulleted),
                    Icon(Icons.featured_play_list),
                  ],
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(
                      () {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      },
                    );
                  },
                ),
              ),
              Expanded(
                  child: (isSelected[0] == true)
                      ? Get_Pet_List(selectedURL: widget.selectedURL)
                      : Get_Pet_Cards(selectedURL: widget.selectedURL)),
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
              child: Center(
                child: ListTile(
                  leading: Icon(
                    Icons.portrait_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Pet Store',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ), //USER Profile if log in
            ),
            ListTile(
                leading: (widget.LoggedIn == true)
                    ? const Icon(
                        Icons.logout,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.login,
                        color: Colors.black,
                      ),
                title: (widget.LoggedIn == true)
                    ? const Text('Log out')
                    : const Text('Login'), //change to logout if logged in
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  if (widget.LoggedIn == false) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const login(),
                      ),
                      (route) => false,
                    );
                  } else if (widget.LoggedIn == true) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PetStoreHomePage(
                          LoggedIn: false,
                        ),
                      ),
                      (route) => false,
                    );
                  }
                } // OnTap
                ),
            Container(
              child: ExpansionTile(
                leading: const Icon(Icons.pets, color: Colors.black),
                title: const Text('Pet'),
                children: <Widget>[
                  // ListTile(leading: Icon(Icons.search),title:Text("Find Pet")),
                  TextButton(
                      child: const ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Add a new Pet")),
                      onPressed: () {
                        //if not logged in, go to login page
                        if (widget.LoggedIn == false) {
                          Toast.show(
                              "Please Log in before adding a pet", context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const login(),
                            ),
                          );
                        } else if (widget.LoggedIn == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const add_pet(),
                            ),
                          );
                        }
                      }),
                  // ListTile(leading: Icon(Icons.add),title:Text("Add a new Pet"))
                ],
                // onTap: () {
                //   // Update the state of the app
                //   // ...
                //   // Then close the drawer
                //   Navigator.pop(context);
                // },
              ),
            ),
            Container(
              child: ExpansionTile(
                leading:
                    const Icon(Icons.local_grocery_store, color: Colors.black),
                title: const Text('Store'),
                children: <Widget>[
                  TextButton(
                    child: const ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text("Place Order")),
                    onPressed: () {
                      if (widget.LoggedIn == false) {
                        Toast.show(
                            "Please Log in before placing an order", context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const login(),
                          ),
                        );
                      } else if (widget.LoggedIn == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Get_Store_Data(),
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: const ListTile(
                        leading: Icon(Icons.search),
                        title: Text("Find an Order")),
                    onPressed: () {
                      if (widget.LoggedIn == false) {
                        Toast.show(
                            "Please Log in before finding an order", context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const login(),
                          ),
                        );
                      } else if (widget.LoggedIn == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Get_Store_Data(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            ExpansionTile(
              leading: GestureDetector(
                child: const Icon(MyFlutterApp.gamepad, color: Colors.black),
                //if double tap set expantiontile title to "Double Tap on Games"
                onDoubleTap: () {
                  setState(() {
                    isDoubled = true;
                  });
                },
                onLongPress: () {
                  setState(() {
                    isLongPressed = true;
                  });
                },
              ),
              title: (isCollapsed == false)
                  ? const Text('Games Expanded')
                  : (isDoubled == true)
                      ? const Text('Double Tap on Games')
                      : (isLongPressed == true)
                          ? const Text('Long Press on Games')
                          : const Text('Games'),
              onExpansionChanged: (bool value) {
                setState(() {
                  isCollapsed = !value;
                  isLongPressed = false;
                  isDoubled = false;
                  print("IS EXPANDED: " + isCollapsed.toString());
                });
              },
              children: <Widget>[
                TextButton(
                  child: const ListTile(
                      leading: Icon(MyFlutterApp.infinity),
                      title: Text("Infinite Scroll Game")),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Guess_Game(),
                    ),
                  ),
                ),
                TextButton(
                  child: const ListTile(
                      leading: Icon(MyFlutterApp.dice_five),
                      title: Text("Guess Game")),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Guess_Game(),
                    ),
                  ),
                ),
                TextButton(
                  child: const ListTile(
                      leading: Icon(Icons.ads_click),
                      title: Text("Click Game")),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Guess_Game(),
                    ),
                  ),
                ),
                TextButton(
                  child: const ListTile(
                      leading: Icon(Icons.check_box),
                      title: Text("Survey Game")),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Guess_Game(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: (widget.LoggedIn == true)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const add_pet(),
                  ),
                  (route) => false,
                );
              },
              backgroundColor: Colors.indigo,
              child: const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.add),
              ),
            )
          : null,
    );
  }
}
