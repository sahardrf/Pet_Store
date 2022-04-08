import 'package:flutter/foundation.dart';

import 'API.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_store/pet.dart';
import 'package:pet_store/API.dart';



class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  // late Future <List<dynamic>> pet_list;

  // @override
  // initState() {
  //   super.initState();
  //   pet_list = API.get_pets();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pets List"),
      ),
      body: Center( 
    child: FutureBuilder<List<dynamic>>(
        future: API.get_pets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data![index]['id'].toString();
                  var name = snapshot.data![index]['name'].toString();
                  var category = snapshot.data![index]['category']['name'].toString();
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Text(id),
                      title: Text(name),
                      subtitle: Text(category)
                      ),
                      // trailing: Text(Category),
                    // ),
                  );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    ),
      );
  }
}