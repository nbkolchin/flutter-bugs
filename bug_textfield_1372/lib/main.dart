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
  bool _searchMode = false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    widget.filterController.addListener(() {
      final text = widget.filterController.text;
      if(widget.filterController.value.selection == null) {
        widget.filterController.value = widget.filterController.value.copyWith(
            text: text,
            selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
            // composing: TextRange.empty,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('TextField Bug line 1372 demo')),
        body: Center(
            child: Column(
                children: <Widget>[
                  OutlineButton(
                      child: Text(_searchMode ? "Hide textfield" : "Show textfield"),
                      onPressed: () {
                        setState(() { _searchMode = !_searchMode; });
                      },
                  ),
                  Visibility(
                      visible: _searchMode,
                      child: TextField(
                          controller: widget.filterController,
                          // autofocus: true,
                          decoration: new InputDecoration(
                              prefixIcon: new Icon(Icons.search),
                              hintText: 'Search...',
                          ),
                      ),
                  ),
                ],
            ),
        ),
    );
  }
}
