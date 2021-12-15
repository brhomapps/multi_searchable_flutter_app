import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_searchable_flutter/search_item.dart';

import 'list_search_view.dart';
import 'multi_search_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// to define the variables
  late StreamController<List<SearchItems>> _streamList;
  late List<SearchItems> namesList;

  @override
  void initState() {
    super.initState();

    /// to control with stream of data ///
    _streamList = StreamController<List<SearchItems>>();
    namesList = getSearch();
    _streamList.sink.add(namesList);
  }

  @override
  Widget build(BuildContext context) {
    /// UI of home page ///
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Multi Search',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                )),
            SizedBox(
              height: 20,
            ),

            /// to call MultiSearchView widget ///
            MultiSearchView(
              inputHint: 'type your text',
              onSelectItem: (value) {
                /// to control when you switch  from an item to another
                filterList(value);
              },
              onSearchComplete: (value) {
                /// to control when you click the keyboard search button

                filterList(value);
              },
              onDeleteAlternative: (value) {
                /// to control when you delete and item and it switch to another item if exist

                filterList(value);
              },
              onItemDeleted: (value) {
                /// to control when you delete an item

                print(value);
              },
              onSearchCleared: () {
                /// to control when all search items are cleared

                removeFilter();
              },
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: _streamList.stream,
                  builder:
                      (context, AsyncSnapshot<List<SearchItems>>? snapshot) {
                    return ListView(
                        children: ((snapshot != null && snapshot.data != null)
                                ? ((snapshot.data?.isNotEmpty ?? false)
                                    ? (snapshot.data
                                        ?.map(
                                          /// code of navigation to new page after click items list ///
                                          (e) => GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                                  return Scaffold(
                                                    appBar: AppBar(
                                                      title: Text(
                                                        /// to call names of items list ///
                                                        e.name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xff2E305F),
                                                    ),

                                                    /// to call pages of list after clicked ///
                                                    body: e.page,
                                                  );
                                                }),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                /// to display all items inside list view ///
                                                ListTile(
                                                  /// to call images of items list ///
                                                  leading: e.image,

                                                  /// to call names of items list ///
                                                  title: Text(e.name),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList())
                                    : [])
                                : []) ??
                            []);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  /// code to filter search the items list by name ///
  void filterList(value) {
    _streamList.sink.add(namesList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList());
  }

  /// code to remove items list by name ///

  void removeFilter() {
    _streamList.sink.add(namesList);
  }

  @override
  void dispose() {
    _streamList.close();
    super.dispose();
  }
}
