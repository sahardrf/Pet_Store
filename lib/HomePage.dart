import 'package:flutter/material.dart';
import 'package:pet_store/widgets/get_pet_cards.dart';
import 'package:pet_store/widgets/get_pet_listview.dart';
import 'package:pet_store/widgets/get_store_data.dart';
import 'package:pet_store/Search.dart';
// import 'package:pet_store/AddPet.dart';


void main() => runApp(const HomePage());
 

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Store',
      home: PetStoreHomePage(),
    );
  }
}

class PetStoreHomePage extends StatefulWidget {
  // const PetStoreHomePage({ Key? key }) : super(key: key);
  // final String url = '';
  final String? selectedURL;
  PetStoreHomePage({
    this.selectedURL,
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
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
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
          });
        },
        
        ),
        ),
        
        Expanded(child: (isSelected[0] == true)? Get_Pet_List(selectedURL: widget.selectedURL): Get_Pet_Cards(selectedURL: widget.selectedURL)),
      //   Container(
      //   padding: const EdgeInsets.all(20),
      //   child: Center(
      //     child: Text(
      //       "Welcome ${widget.selectedURL}",
      //       style: TextStyle(
      //         fontSize: 25,
      //       ),
      //     ),
      //   ),
      // ),
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

// = 'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available'