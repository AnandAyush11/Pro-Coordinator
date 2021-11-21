import 'package:procoordinator/models/project.dart';

class Student {
  String name;
  String email;
  String enrollNo;
  int state;
  List<Project> projects;

  Student({
    required this.name,
    required this.email,
    required this.enrollNo,
    required this.state,
    required this.projects,
  });
}
