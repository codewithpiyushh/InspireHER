import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // For opening links

class BusinessPreferences {
  static Future<String> getSelectedBusiness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selected_business') ?? "Dairy";
  }
}

class GovernmentCoursesPage extends StatefulWidget {
  const GovernmentCoursesPage({super.key});

  @override
  _GovernmentCoursesPageState createState() => _GovernmentCoursesPageState();
}

class _GovernmentCoursesPageState extends State<GovernmentCoursesPage> {
  String selectedBusiness = "";
  List<Map<String, String>> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGovernmentCourses();
  }

  Future<void> _fetchGovernmentCourses() async {
    String business = await BusinessPreferences.getSelectedBusiness();
    setState(() => selectedBusiness = business);

    List<Map<String, String>> fetchedCourses =
        await _fetchCoursesFromAPI(business);

    setState(() {
      courses = fetchedCourses;
      isLoading = false;
    });
  }

  Future<List<Map<String, String>>> _fetchCoursesFromAPI(
      String business) async {
    String url =
        "http://192.168.1.4:5001/get-courses?business=$business"; // Update with actual API URL
    List<Map<String, String>> coursesList = [];

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var course in data["courses"]) {
          coursesList.add({
            "title": course["title"],
            "link": course["link"],
            "provider": course["provider"]
          });
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }

    return coursesList;
  }

  void _openCourseLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not open $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Govt. Courses for $selectedBusiness")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : courses.isEmpty
              ? Center(child: Text("No courses found for $selectedBusiness"))
              : ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          courses[index]["title"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text("Provider: ${courses[index]["provider"]}"),
                        trailing: Icon(Icons.open_in_new, color: Colors.blue),
                        onTap: () => _openCourseLink(courses[index]["link"]!),
                      ),
                    );
                  },
                ),
    );
  }
}
