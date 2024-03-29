import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController mycontroller = TextEditingController();
  late List<bool> isSelected;
  String? dropdownvalue;
  var items = [
    'Available',
    'Pending',
    'Sold',
  ];

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
        title: Text('Find Pet'),
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
                builder: (BuildContext context) => const HomePage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body:  GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Column(
            children: [
              const Text("   "),
              Align(
                alignment: Alignment.topCenter,
                child: ToggleButtons(
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
              Container(
                child: (isSelected[0] == true)
                    ? DropdownButton(
                        hint: const Text('Select Status'),
                        // Initial Value
                        value: dropdownvalue,
      
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
      
                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      )
                    : (isSelected[1] == true)
                        ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                              controller: mycontroller,
                              decoration: const InputDecoration(
                                labelText: 'Enter ID',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                              // Only numbers can be entered
                            ),
                        )
                        : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                              controller: mycontroller,
                              decoration: const InputDecoration(
                                labelText: 'Enter Tags',
                                hintText: 'Separate tags with comma',
                              ),
                            ),
                        ),
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
                onPressed: () {
                  var url = select_url(isSelected, mycontroller.text);
                  print('SEARCH');
                  print(url);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PetStoreHomePage(
                        selectedURL: url,
                      ),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  select_url(first_search_filter, second_search_filter) {
    String url;
    if (first_search_filter[0] == true) {
      second_search_filter = dropdownvalue;
      if (second_search_filter == 'Available' || second_search_filter == 'available') {
        url =
            'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
        return url;
      } else if (second_search_filter == 'Pending' || second_search_filter == 'pending') {
        url =
            'https://api.training.testifi.io/api/v3/pet/findByStatus?status=pending';
        return url;
      } else if (second_search_filter == 'Sold' || second_search_filter == 'sold') {
        url =
            'https://api.training.testifi.io/api/v3/pet/findByStatus?status=sold';
        return url;
      }
    } else if (first_search_filter[1] == true) {
      url = ('https://api.training.testifi.io/api/v3/pet/' +
              (second_search_filter))
          .toString();
      return url;
    } else if (first_search_filter[2] == true) {
      String baseURL = 'https://api.training.testifi.io/api/v3/pet/findByTags?';
      var tags = second_search_filter.split(' ');
      String t, tURL = '';
      String url = '';
      for (var i = 0; i < tags.length; i++) {
        tURL = tURL + 'tags=' + (tags[i]).toString() + '&';
        print(tURL);
        url = baseURL + tURL;
      }
      return url;
    } else {
      print('NO AVAILABLE FILTERS');
    }
  }
}
