import 'package:flutter/material.dart';
import 'package:pet_store/HomePage.dart';

class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController mycontroller = TextEditingController();
  late List<bool> isSelected;


  @override
  void initState() {
      isSelected = [true, false, false];
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Text('Search Pets'),
        ),
        body: Center(
        child: Column(children: [
          const Text("   "),
          Align(
            alignment: Alignment.topCenter,
            child:ToggleButtons(
                borderColor: Color.fromARGB(255, 99, 98, 98),
                fillColor: Color.fromARGB(255, 99, 98, 98),
                borderWidth: 1,
                selectedBorderColor: Color.fromARGB(255, 99, 98, 98),
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                children: const <Widget>[
                    Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Status',
                        style: TextStyle(fontSize: 16),
                    ),
                    ),
                    Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'ID',
                        style: TextStyle(fontSize: 16),
                    ),
                    ),
                    Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Tags',
                        style: TextStyle(fontSize: 16),
                    ),
                    ),
                ],
                onPressed: (int index) {
                    setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                        print(isSelected);
                    }
                    });
                },
                isSelected: isSelected,
                ),
            ),
            TextField(
                controller: mycontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            // Expanded(child: (isSelected[0]== true)? TextField: (isSelected[1]== true)? TextField:TextField),	
            FlatButton(
              child: Text('Search', style: TextStyle(fontSize: 17.0),),  
                color: Colors.indigo,  
                textColor: Colors.white, 
              onPressed: () {
                  var url = select_url(isSelected, mycontroller.text);
                  print('SEARCH');
                  print(url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetStoreHomePage(
                        selectedURL: url,
                      ),
                    ),
                  );
                // pass url to homepage screen
              }
            ),
        ],
            ),
        ),
        );
    }
select_url(first_search_filter, second_search_filter){
  String url;
    if(first_search_filter[0] == true){
      if(second_search_filter == 'available'){
        url = 'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
        return url;
      }
      else if(second_search_filter == 'pending'){
        url = 'https://api.training.testifi.io/api/v3/pet/findByStatus?status=pending';
        return url;
      }
      else if(second_search_filter == 'sold'){
        url = 'https://api.training.testifi.io/api/v3/pet/findByStatus?status=sold';
        return url;
      }
    }
    
    else if (first_search_filter[1] == true){
      url = ('https://api.training.testifi.io/api/v3/pet/'+(second_search_filter)).toString();
      return url;
    }

    else if (first_search_filter[2] == true){
      String baseURL = 'https://api.training.testifi.io/api/v3/pet/findByTags?';
      var tags = second_search_filter.split(' ');
      String t, tURL = '';
      String url='';
      for (var i = 0; i < tags.length; i++) {
        tURL = tURL + 'tags='+ (tags[i]).toString() +'&';
        print(tURL);
        url = baseURL+tURL;
        }
        return url;
      }
    
    else {
      print('NO AVAILABLE FILTERS');
    }
  
    // else if(first_search_filter[1] == true){}
    // else if(first_search_filter[2] == true){}
}

bool equalsIgnoreCase(String a, String b) =>
    (a == null && b == null) ||
    (a != null && b != null && a.toLowerCase() == b.toLowerCase());

    }
