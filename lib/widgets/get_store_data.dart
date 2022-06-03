import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/models/store.dart';
import '../webservice/API.dart';

class Get_Store_Data extends StatelessWidget {
  const Get_Store_Data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: FutureBuilder<List>(
          future: API.get_store_data(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? store_data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var approved = snapshot.data![index]['approved'].toString();
                    var placed = snapshot.data![index]['placed'].toString();
                    var delivered =
                        snapshot.data![index]['delivered'].toString();
                    return Column(
                      children: [
                        Card(
                          color: Color.fromARGB(255, 194, 191, 191),
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: ListTile(
                            title: const Text(
                              "Approved:",
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 58, 58),
                              ),
                            ),
                            trailing: Text(
                              approved,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Color.fromARGB(255, 194, 191, 191),
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: ListTile(
                            title: const Text(
                              "Placed:",
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 58, 58),
                              ),
                            ),
                            trailing: Text(
                              placed,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Color.fromARGB(255, 194, 191, 191),
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          child: ListTile(
                            title: const Text(
                              "Delivered:",
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 58, 58),
                              ),
                            ),
                            trailing: Text(
                              delivered,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
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
