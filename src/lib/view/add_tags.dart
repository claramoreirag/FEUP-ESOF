import 'package:flutter/material.dart';



class AddTags extends StatefulWidget {
  AddTags({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddTags createState() => _AddTags();
}

class _AddTags extends State<AddTags> {
  final List<String> tags = <String>[];
  
  TextEditingController tagController = TextEditingController();

  void addItemToList(){
    setState(() {
      tags.insert(0,tagController.text);
      tagController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tags'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: tagController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tag'
              ),
            ),
          ),
          RaisedButton(
            child: Text('Insert tag'),
            onPressed: () {
              addItemToList();
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 50,
                  margin: EdgeInsets.all(2),
                  child: Center(
                    child: Text('${tags[index]}',
                      style: TextStyle(fontSize: 18),
                    )
                  ),
                );
              }
            )
          )
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.pop(context, tags);
          },
      ),
    );
  }

}
