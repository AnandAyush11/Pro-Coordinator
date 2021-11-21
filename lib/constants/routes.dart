import 'package:flutter/material.dart';

import '../screens/faculty_dashboard.dart';
import '../screens/student_dashboard.dart';

Map<String, Widget Function(BuildContext)> routes = {
  StudentDashboard.routeName: (ctx)=> const StudentDashboard(),
  FacultyDashboard.routeName:(ctx)=>const FacultyDashboard()
};
