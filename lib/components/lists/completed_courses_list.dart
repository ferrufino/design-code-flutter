import 'package:designcode/components/cards/completed_courses_card.dart';
import 'package:designcode/components/cards/continue_watching_card.dart';
import 'package:designcode/model/course.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompletedCoursesList extends StatefulWidget {
  @override
  _CompletedCoursesListState createState() => _CompletedCoursesListState();
}

class _CompletedCoursesListState extends State<CompletedCoursesList> {
  List<Container> indicators = [];
  int currentPage = 0;

  var completedCourses = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: completedCourses.map((course) {
        var index = completedCourses.indexOf(course);
        return Container(
          width: 7.0,
          height: 7.0,
          margin: EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  currentPage == index ? Color(0xFF0971FE) : Color(0xFFA6AEBD)),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    getCompletedCourses();
  }

  void getCompletedCourses() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((snapshot) {
      for (var course in snapshot["completed"]) {
        _firestore
            .collection("courses")
            .doc(course)
            .get()
            .then((courseSnapshot) {
              print(courseSnapshot["courseTitle"]);
          setState(() {
            completedCourses.add(Course(
                courseTitle: courseSnapshot["courseTitle"],
                courseSubtitle: courseSnapshot["courseSubtitle"],
                illustration: courseSnapshot["illustration"],
                logo: courseSnapshot["logo"],
                background: LinearGradient(colors: [
                  Color(int.parse(courseSnapshot["colors"][0])),
                  Color(int.parse(courseSnapshot["colors"][1])),
                ])));
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.0,
          width: double.infinity,
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Opacity(
                  opacity: currentPage == index ? 1.0 : 0.5,
                  child: CompletedCoursesCard(
                    course: completedCourses[index],
                  ));
            },
            itemCount: completedCourses.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: PageController(initialPage: 0, viewportFraction: 0.75),
          ),
        ),
        updateIndicators(),
      ],
    );
  }
}
