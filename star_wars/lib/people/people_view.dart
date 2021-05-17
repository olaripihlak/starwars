import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_wars/database/database.dart';
import 'package:star_wars/people/people_request.dart';
import 'package:star_wars/people/people_response.dart';
import 'package:star_wars/people/person_response.dart';
import 'package:star_wars/person/person_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database.instance.initDatabase().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    fetchPeople();
  }

  Future<void> fetchPeople() async {
    try {
      await PeopleRequest().requestPeople(Database.instance);
    } catch (err) {
      print("fetchPeople error: " + err.toString());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      if (state == AppLifecycleState.resumed) {
        // Refresh data.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starwars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('People'),
        ),
        body: ValueListenableBuilder(
          valueListenable: Database.instance.getPeople().listenable(),
          builder: (context, Box<PeopleResponse> box, _) {
            //_showToast(context, "df");
            if (box.values.isEmpty)
              return Center(
                child: Text("People list empty"),
              );
            List<PersonResponse>? personResponse =
                box.get(Database.OBJECT_PEOPLE)?.personResponse;

            return personResponse == null
                ? Text("Something went wrong")
                : getPeopleListView(personResponse);
          },
        ),
      ),
    );
  }

  ListView getPeopleListView(List<PersonResponse> personResponse) =>
      ListView.builder(
        itemCount: personResponse.length,
        itemBuilder: (context, index) {
          return Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonView(personResponse: personResponse[index]),
                    ));
              },
              child: Container(
                height: 100,
                child: Text(
                  personResponse[index].name,
                  style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      backgroundColor: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      );
}
