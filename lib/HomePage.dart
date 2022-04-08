import 'package:flutter/material.dart';
import 'widgets/get_pet_list.dart';



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pets List"),
      ),
      body: Get_Pet_List(),
      );
  }
}