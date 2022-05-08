import 'package:flutter/material.dart';
import 'package:pet_store/widgets/get_pet_cards.dart';
import 'package:pet_store/widgets/get_pet_listview.dart';
import 'package:pet_store/widgets/get_store_data.dart';

void main() => runApp(const HomePage());
 

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
  bool status = false;
  late List<bool> isSelected;


  @override
  void initState() {
      isSelected = [true, false];
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget get_pet_list(){
      return Expanded(child: Get_Pet_List());
    }
        Widget get_pet_cards(){
      return Expanded(child: Get_Pet_Cards());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed:(){
                //do something
            },
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
          Align(
            alignment: Alignment.topCenter,
            child: ToggleButtons(children: const <Widget>[
                  Icon(Icons.format_list_bulleted),
                  Icon(Icons.featured_play_list),
        ], 
        isSelected: isSelected,
        onPressed: (int index){
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          });
        },
        
            color: Color.fromARGB(255, 99, 98, 98),
            selectedColor: Colors.white,
            fillColor: Color.fromARGB(255, 99, 98, 98),
            // selectedBorderColor: Color.fromARGB(255, 99, 98, 98),
            // borderRadius: BorderRadius.all(Radius.circular(5)),
            borderWidth: 0,
        ),
        ),
          Expanded(child: (isSelected[0] == true)? Get_Pet_List(): Get_Pet_Cards()),
          // const Expanded(child: Get_Pet_List())
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