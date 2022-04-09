import 'package:flutter/material.dart';
import 'package:pet_store/widgets/get_pet_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Pet Store',
        home: PetStoreHomePage(),
);

  }
}

 class PetStoreHomePage extends StatefulWidget {
    const PetStoreHomePage({ Key? key }) : super(key: key);
  
    @override
    _PetStoreHomePageState createState() => _PetStoreHomePageState();
  }
  
  class _PetStoreHomePageState extends State<PetStoreHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("User Home Page"),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(child: Get_Pet_List())
          // FloatingActionButton(onPressed: addpet)
          
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("List of Stores"),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Store Home Page'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: "Pet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: "Store",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}