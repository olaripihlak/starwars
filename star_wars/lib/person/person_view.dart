import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/people/person_response.dart';

class PersonView extends StatelessWidget {
  final PersonResponse personResponse;

  PersonView({Key? key, required this.personResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personResponse.name.toString()),
      ),
      body: MyPersonView(personResponse: personResponse),
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
    return Center(
      child: ElevatedButton(
        child: Text(widget.personResponse.name.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
