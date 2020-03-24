import 'dart:convert';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './apex_flutter_app_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apex Tracker',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.black12,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              title: TextStyle(
                  fontSize: 36.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
              body1: TextStyle(
                  fontSize: 14.0, fontFamily: 'Hind', color: Colors.black))),
      home: MyHomePage(title: 'Apex Stat Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Controls text label being used as a search bar
  final TextEditingController _filter = new TextEditingController();
  Widget _appBarTitle = new Text(searchTitle);
  Icon _searchIcon = new Icon(Icons.search);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // The stack start with items from the bottom, this is what is needed
      // to have transparency on the appBar
      body: new Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme
//                  .of(context)
//                  .textTheme
//                  .display1,
//            ),
//            new Container(
//              child: new FutureBuilder<String>(
//                future: fetchUsersFromApi(),
//                // ignore: missing_return
//                builder: (context, AsyncSnapshot<String> snapshot) {
//                  if (snapshot.hasData) {
//                    return new Text(snapshot.data
//                        //snapshot.data.cases.toString()
//                        );
//                  }
//                },
//              ),
//            )
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/pathfinder_portrait"
                        ".jpg"),
                    fit: BoxFit.cover)),
          ),
//          Positioned(
//              top: 0.0,
//              left: 0.0,
//              right: 0.0,
//              child: )
          AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: _appBarTitle,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  })
            ],
          ),
        ],
      ),
//      3rd party FAB [https://github.com/marianocordoba/fab-circular-menu]
      floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
                  animationDuration: Duration(milliseconds: 400),
                  children: <Widget>[
                    IconButton(
                        icon:
                            //ImageIcon(AssetImage("images/xbox.png"),
                            //  color: Color(0xFF3A5A98)),
                            Icon(ApexFlutterApp.xbox),
                        onPressed: () {
                          platform = "1";
                          print("HOME");
                          //Scaffold.of(context).showSnackBar(SnackBar(
//                content: Text("TEST")
//              ));
                        }),
                    IconButton(
                        icon: Icon(ApexFlutterApp.playstation),
                        onPressed: () {
                          platform = "2";
                          print("Favorite");
                        }),
                    IconButton(
                        icon: Icon(ApexFlutterApp.laptop),
                        onPressed: () {
                          platform = "5";
                          print("PS4");
                        })
                  ])),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> fetchUsersFromApi(String username) async {
    Map<String, String> headersDood = {
      'TRN-Api-Key': 'f999ff69-368c-4e4e-9383-30cdbbbbf812'
    };
    //AOE
//    final response = await http.get('http://age-of-empires-2-api.herokuapp'
//        '.com/api/v1/civilizations');
    final response = await http.get(
        'https://public-api.tracker.gg/apex/v1/standard/profile/$platform/$username',
        headers: headersDood);
    return jsonDecode(response.body.toString()).toString();
//    Cases value = createCases(responseJson);
//    return value;
  }
}

//Handle Search Bar actions
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return new Container(
      child: new FutureBuilder<String>(
        future: _MyHomePageState().fetchUsersFromApi(query),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return new Text(snapshot.data);
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/bloodhound_portrait.jpg"),
              fit: BoxFit.cover)),
    );
  }
}

class Player {
  int id;
  String type;
}

const String searchTitle = 'Search Apex Player';
const String xbox = "1";
const String psn = "2";
const String origin = "5";
//Temp global key for platform filter
String platform = "";
