class Driver {
  String firstName;
  String lastName;
  String city;
  List<String> routes;
  String startTime;
  String endTime;
  String password;

  Driver({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.routes,
    required this.startTime,
    required this.endTime,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'city': city,
      'routes': routes,
      'startTime': startTime,
      'endTime': endTime,
      'password': password,
    };
  }
}
