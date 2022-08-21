import 'dart:developer';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';
import 'package:pet_store/presentation/my_flutter_app_icons.dart';

import 'main.dart';
import 'widgets/BoardItemObject.dart';
import 'widgets/BoardListObject.dart';

class Favorite_Pet extends StatefulWidget {
  const Favorite_Pet({Key? key}) : super(key: key);

  @override
  State<Favorite_Pet> createState() => _Favorite_PetState();
}

class _Favorite_PetState extends State<Favorite_Pet> {
  BoardViewController boardViewController = new BoardViewController();
  final List<BoardListObject> _listData = [
    BoardListObject(title: "Pets List"),
    BoardListObject(title: "Favorite Pets List"),
  ];

  List<BoardItem> items = [
    BoardItem(
      item: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        key: const ValueKey("Kitty"),
        elevation: 5.0,
        child: const ListTile(
          title: Text(
            "Kitty",
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    ),
    BoardItem(
      item: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        key: const ValueKey("Puppy"),
        elevation: 5.0,
        child: const ListTile(
          title: Text(
            "Puppy",
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    ),
    BoardItem(
      item: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        key: const ValueKey("Bunny"),
        elevation: 5.0,
        child: const ListTile(
          title: Text(
            "Bunny",
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    ),
    BoardItem(
      item: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        key: const ValueKey("Fish"),
        elevation: 5.0,
        child: const ListTile(
          title: Text(
            "Fish",
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    ),
    BoardItem(
      item: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 83, 83, 83),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        key: const ValueKey("Hedgehog"),
        elevation: 5.0,
        child: const ListTile(
          title: Text(
            "Hedgehog",
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    _lists.add(_createBoardList(_listData[0], items) as BoardList);
    _lists.add(_createBoardList(_listData[1], []) as BoardList);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Favorite Pet Game'),
        leading: GestureDetector(
          child: const Icon(
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
      body: Flex(direction: Axis.vertical, children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Favorite Pet to adopt",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Icon(MyFlutterApp.hand_holding_heart),
                const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BoardView(
            lists: _lists,
            boardViewController: boardViewController,
          ),
        ),
      ]),
      //   ],
      // ),
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        //Used to update our local item data
        var item = _listData[oldListIndex!].items![oldItemIndex!];
        _listData[oldListIndex].items!.removeAt(oldItemIndex!);
        _listData[listIndex!].items!.insert(itemIndex!, item);
      },
      onTapItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) async {},
      item: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(itemObject.title!),
        ),
      ),
    );
  }

  Widget _createBoardList(BoardListObject list, List<BoardItem> items) {
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex!);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Color.fromARGB(255, 180, 180, 180),
      backgroundColor: Color.fromARGB(255, 215, 216, 219),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  list.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
      ],
      items: items,
    );
  }
}
