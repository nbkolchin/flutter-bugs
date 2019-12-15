/* Original sample with tabs */

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DemoBug1372(title: 'Demo TextField Bug 1372'),
    );
  }
}

class DemoBug1372 extends StatefulWidget {
  final String title;
  final TextEditingController filterController = TextEditingController();

  DemoBug1372({Key key, this.title}) : super(key: key);

  @override
  _DemoBug1372 createState() => _DemoBug1372();
}

class _DemoBug1372 extends State<DemoBug1372> with SingleTickerProviderStateMixin {
  bool _hasSearchMode = false;
  bool _searchMode = false;
  TabController _tabController;

  Widget _buildBar(BuildContext context) {
    AppBar bar;
    if(!_hasSearchMode) {
      bar = AppBar(
          title: Text('No search...'),
      );
    } else if(!_searchMode) {
      bar = AppBar(
          title: Text('With Search...'),
          actions: <Widget> [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() { _searchMode = true; });
                },
            ),
          ],
      );
    } else {
      bar = AppBar(
          automaticallyImplyLeading: false,
          // elevation: 0.0,
          title: TextField(
              controller: widget.filterController,
              autofocus: true,
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search...',
              ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _searchMode = false;
                    widget.filterController.clear();
                  });
                }
            ),
          ]
      );
    }
    return bar;
  }

  Widget _makeWidget(String s) {
    return Center(child: Text(s));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      int n = _tabController.index;
      bool b = n == 1 || n == 2;
      if(b != _hasSearchMode) {
        setState(() {
          _hasSearchMode = b;
        });
      }
    });
    widget.filterController.addListener(() {
      final text = widget.filterController.text;
      if(widget.filterController.value.selection == null) {
        widget.filterController.value = widget.filterController.value.copyWith(
            // text: text,
            selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
            // composing: TextRange.empty,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildBar(context),
        body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _makeWidget("Screen 1. No search"),
              _makeWidget("Screen 2. Has search"),
              _makeWidget("Screen 3. Has search"),
              _makeWidget("Screen 4. No search"),
            ],
        ),
        bottomNavigationBar: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontSize: 11),
            tabs: <Tab>[
              Tab(text: "Screen 1"),
              Tab(text: "Screen 2"),
              Tab(text: "Screen 3"),
              Tab(text: "Screen 4"),
            ],
        ),
    );
  }
}
