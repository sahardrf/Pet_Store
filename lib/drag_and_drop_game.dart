import 'package:flutter/material.dart';

class Drag_and_Drop_Game extends StatefulWidget {
  const Drag_and_Drop_Game({Key? key}) : super(key: key);

  @override
  State<Drag_and_Drop_Game> createState() => _Drag_and_Drop_GameState();
}

class _Drag_and_Drop_GameState extends State<Drag_and_Drop_Game> {
  final List<String> tasks = ['Bunny', 'Fish', 'Hedgehog', 'Kitty', 'Puppy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Drag and Drop'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }
            });
            final task = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, task);
          },
          children: [
            for (final task in tasks)
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 83, 83, 83),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
                key: ValueKey(task),
                elevation: 5.0,
                child: ListTile(
                  title: Text(
                    task,
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(Icons.drag_handle, color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
