import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_wars/database/database.dart';
import 'package:star_wars/homeworld/home_world_response.dart';
import 'package:star_wars/networking/api_service.dart';
import 'package:star_wars/people/person_response.dart';
import 'package:star_wars/util/snack_bar_util.dart';

class HomeWorldView extends StatelessWidget {
  final PersonResponse personResponse;

  HomeWorldView({Key? key, required this.personResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personResponse.name.toString()),
      ),
      body: MyHomeWorldView(personResponse: personResponse),
    );
  }
}

class MyHomeWorldView extends StatefulWidget {
  final PersonResponse personResponse;

  MyHomeWorldView({Key? key, required this.personResponse}) : super(key: key);

  @override
  _MyHomeWorldView createState() => _MyHomeWorldView();
}

class _MyHomeWorldView extends State<MyHomeWorldView> {
  late Future<HomeWorldResponse> homeWorldResponse;

  @override
  void initState() {
    super.initState();
    homeWorldResponse =
        ApiService.instance.requestHomeWorld(widget.personResponse.homeworld!);
  }

  @override
  Widget build(BuildContext context) {
    return homeWorldWidget(context);
  }

  Widget homeWorldWidget(BuildContext context) {
    return FutureBuilder<HomeWorldResponse>(
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

        HomeWorldResponse? homeWorldResponse = projectSnap.data;
        if (homeWorldResponse != null) {
          Database.instance.saveHomeWorld(
              widget.personResponse.homeworld!, homeWorldResponse);
        }

        return Scaffold(
            body: ValueListenableBuilder(
          valueListenable: Database.instance.getHomeWorld().listenable(),
          builder: (context, Box<HomeWorldResponse> box, _) {
            if (box.values.isEmpty)
              return Center(
                child: Text("Home world not found!"),
              );
            HomeWorldResponse? homeWorldResponse =
                box.get(widget.personResponse.homeworld!);
            return Text(homeWorldResponse?.name?.toString() ?? "No name");
          },
        ));
      },
      future: homeWorldResponse,
    );
  }
}
