import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars/database/database.dart';
import 'package:star_wars/people/people_request.dart';
import 'package:star_wars/people/people_response.dart';
import 'package:star_wars/people/person_response.dart';
import 'package:star_wars/person/person_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(PeopleResponseAdapter());
  Hive.registerAdapter(PersonResponseAdapter());
  runApp(MyApp());
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
  late Future<PeopleResponse> futurePeople;
  Database database = Database();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    futurePeople = PeopleRequest().requestPeople(database);
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
        setState(() {
          futurePeople = PeopleRequest().requestPeople(database);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<PeopleResponse>(
            future: futurePeople,
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError || data == null) {
                // _showToast(context, "${snapshot.error}");
                return Text("${snapshot.error}");
              }

              return getPeopleListView(data);
            },
          ),
        ),
      ),
    );
  }

  ListView getPeopleListView(PeopleResponse data) => ListView.builder(
        itemCount: data.personResponse.length,
        itemBuilder: (context, index) {
          PersonResponse personResponse = data.personResponse[index];
          return Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonView(
                          personResponse: data.personResponse[index]),
                    ));
              },
              child: Container(
                height: 100,
                child: Text(
                  personResponse.name,
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

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
