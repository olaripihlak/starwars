import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/database/database.dart';
import 'package:star_wars/homeworld/home_world_view.dart';
import 'package:star_wars/networking/api_service.dart';
import 'package:star_wars/people/people_model.dart';
import 'package:star_wars/people/people_response.dart';
import 'package:star_wars/people/person_response.dart';
import 'package:star_wars/ui/constants.dart';
import 'package:star_wars/util/snack_bar_util.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database.instance.initDatabase().then((value) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => PeopleModel(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<PeopleModel>(
      builder: (context, cart, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme:
              cart.lightMode ? getLightTheme(context) : getDarkTheme(context),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    futurePeople = ApiService.instance.requestPeople();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starwars'),
        actions: [
          Switch(
              value: context.read<PeopleModel>().lightMode,
              onChanged: (val) {
                context.read<PeopleModel>().setIsLightMode(val);
              }),
        ],
      ),
      body: peopleWidget(context),
    );
  }

  Widget peopleWidget(BuildContext context) {
    return FutureBuilder<PeopleResponse>(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (projectSnap.hasError == true) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            SnackBarUtil.showSnack(context, projectSnap.error.toString());
          });
        }

        PeopleResponse? peopleResponse = projectSnap.data;
        if (peopleResponse != null) {
          Database.instance.savePeople(peopleResponse);
        }

        return Scaffold(
            body: ValueListenableBuilder(
          valueListenable: Database.instance.getPeople().listenable(),
          builder: (context, Box<PeopleResponse> box, _) {
            if (box.values.isEmpty)
              return Center(
                child: Text("People list empty"),
              );
            List<PersonResponse>? personResponse =
                box.get(Database.OBJECT_PEOPLE)?.personResponse;
            return personResponse == null
                ? Text("Something went wrong")
                : getPeopleListView(personResponse, context);
          },
        ));
      },
      future: futurePeople,
    );
  }

  ListView getPeopleListView(
          List<PersonResponse> personResponse, BuildContext context) =>
      ListView.builder(
        itemCount: personResponse.length,
        itemBuilder: (context, index) {
          return Card(
            color: context.read<PeopleModel>().lightMode
                ? cardBgColorLight
                : cardBgColorDark,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return showBottomSheet(context, personResponse[index]);
                      });
                },
                child: Text(
                  personResponse[index].name ?? "",
                  style: TextStyle(fontSize: 40.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      );

  Column showBottomSheet(BuildContext context, PersonResponse personResponse) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("name:" + (personResponse.name ?? "")),
        Text("height:" + (personResponse.height ?? "")),
        Text("mass:" + (personResponse.mass ?? "")),
        Text("hair color:" + (personResponse.hair_color ?? "")),
        Text("skin color:" + (personResponse.skin_color ?? "")),
        Text("eye color:" + (personResponse.eye_color ?? "")),
        Text("birth year:" + (personResponse.birth_year ?? "")),
        Text("gender:" + (personResponse.gender ?? "")),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeWorldView(personResponse: personResponse),
                ));
          },
          child: Text("home world: " + (personResponse.homeworld ?? "")),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeWorldView(personResponse: personResponse),
                ));
          },
          child: Text('Show home world'),
        ),
      ],
    );
  }
}
