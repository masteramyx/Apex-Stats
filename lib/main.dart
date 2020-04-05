import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:empires/models/Player.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'customicons/apex_flutter_app_icons.dart';

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
          accentColor: Colors.white,
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
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  Widget _appBarTitle = new Text(searchTitle);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // The stack start with items from the bottom, this is what is needed
      // to have transparency on the appBar
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/pathfinder_portrait"
                        ".jpg"),
                    fit: BoxFit.cover)),
          ),
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
                  key: fabKey,
                  ringColor: Colors.black26,
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
                          fabKey.currentState.close();
                        }),
                    IconButton(
                        icon: Icon(ApexFlutterApp.playstation),
                        onPressed: () {
                          platform = "2";
                          print("Favorite");
                          fabKey.currentState.close();
                        }),
                    IconButton(
                        icon: Icon(ApexFlutterApp.laptop),
                        onPressed: () {
                          platform = "5";
                          print("PS4");
                          fabKey.currentState.close();
                        })
                  ])),
    );
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
      child: new FutureBuilder<PlayerData>(
        future: fetchUsersFromApi(query),
        builder: (context, AsyncSnapshot<PlayerData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              ));
              break;
            default:
              if (snapshot.hasError) {
                return new Text("Error getting player (Check if name spelled "
                    "correctly");
              }
              if (snapshot.hasData) {
                Player player = new Player.fromJson(snapshot.data.player);
                return Container(
                    decoration: new BoxDecoration(color: Colors.white),
                    constraints: BoxConstraints.expand(),
                    child: new SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: new Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text("Username "),
                            Text(player.name)
                          ]),
                          Row(
                            children: <Widget>[
                              Text("Level: "),
                              Text(player.level.toString())
                            ],
                          ),
                          CachedNetworkImage(
                            imageUrl: player.rankImage,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                          Divider(color: Colors.black),
                          Row(
                            children: <Widget>[Text("Characters: ")],
                          ),
                          buildCharacterListView(snapshot.data)
                        ],
                      ),
                    ));
              }
          }
          return CircularProgressIndicator();
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

  ListView buildCharacterListView(PlayerData playerData) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: playerData.characters.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: playerData.characters[index].characterInfo.icon,
                placeholder: (context, url) => CircularProgressIndicator(),
              )
            ],
          );
        });
  }

  Future<PlayerData> fetchUsersFromApi(String username) async {
    Map<String, String> headersDood = {
      'TRN-Api-Key': 'f999ff69-368c-4e4e-9383-30cdbbbbf812'
    };
    final response =
        await http.get('$baseUrl/$platform/$username', headers: headersDood);
    final jsonResponse = jsonDecode(response.body);
    PlayerResponse playerResponse = new PlayerResponse.fromJson(jsonResponse);
    PlayerData playerMetadata = new PlayerData.fromJson(playerResponse.data);
    return playerMetadata;
  }
}

const String searchTitle = 'Search Apex Player';
const String xbox = "1";
const String psn = "2";
const String origin = "5";
const String baseUrl = "https://public-api.tracker.gg/apex/v1/standard/profile";
//Temp global key for platform filter
String platform = "5";
