import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/people/person_response.dart';

class PersonView extends StatelessWidget {
  final PersonResponse personResponse;

  PersonView({Key? key, required this.personResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPersonView(personResponse: personResponse),
    );
  }
}

class MyPersonView extends StatefulWidget {
  final PersonResponse personResponse;

  MyPersonView({Key? key, required this.personResponse}) : super(key: key);

  @override
  _MyPersonView createState() => _MyPersonView();
}

class _MyPersonView extends State<MyPersonView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.personResponse.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.personResponse.name),
          ),
          body: Text(widget.personResponse.name)),
    );
  }
}
