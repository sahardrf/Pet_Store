import 'package:flutter/material.dart';
import 'package:pet_store/utils/utils.dart';
import 'package:pet_store/widgets/random_pet_image.dart';
import 'webservice/API.dart';

import 'main.dart';

class Infinite_Scroll_Game extends StatefulWidget {
  const Infinite_Scroll_Game({Key? key}) : super(key: key);

  @override
  State<Infinite_Scroll_Game> createState() => _Infinite_Scroll_GameState();
}

class _Infinite_Scroll_GameState extends State<Infinite_Scroll_Game> {
  List<int> dataList = [];
  bool isLoading = false;
  int pageCount = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ////LOADING FIRST  DATA
    addItemIntoLisT(1);

    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("comes to bottom $isLoading");
        isLoading = true;

        if (isLoading) {
          print("RUNNING LOAD MORE");

          pageCount = pageCount + 1;

          addItemIntoLisT(pageCount);
        }
      });
    }
  }

  ////ADDING DATA INTO ARRAYLIST
  void addItemIntoLisT(var pageCount) {
    for (int i = (pageCount * 10) - 10; i < pageCount * 10; i++) {
      dataList.add(i);
      isLoading = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Infinite Scroll Game'),
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
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: GridView.count(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            physics: const AlwaysScrollableScrollPhysics(),
            children: dataList.map((value) {
              return const Random_Image_Card();
            }).toList(),
          )),
    );
  }
}
