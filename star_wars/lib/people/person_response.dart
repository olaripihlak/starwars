class PersonResponse {
  final String name;

  PersonResponse({required this.name});

  factory PersonResponse.convertPersonResponse(Map<String, dynamic> json) {
    return PersonResponse(name: json['name']);
  }
}
