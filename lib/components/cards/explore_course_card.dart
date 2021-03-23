import 'package:designcode/model/course.dart';
import 'package:flutter/material.dart';
import 'package:designcode/constants.dart';

class ExploreCourseCard extends StatelessWidget {
  ExploreCourseCard({@required this.course}); //initialization manually define

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: ClipRRect(
        //This will clip any content that spills outside of the container. It will also give us access to round the corners of the card.
        borderRadius: BorderRadius.circular(41.0),
        child: Container(
            height: 120.0,
            width: 280.0,
            decoration: BoxDecoration(gradient: course.background),
            child: Padding(
              padding: EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Expanded( //content in card
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.courseSubtitle,
                          style: kCardSubtitleStyle,
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          course.courseTitle,
                          style: kCardTitleStyle,
                        ),
                      ],
                    ),
                  ),
                  Column( // image of the widget
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('asset/illustrations/${course.illustration}',
                          fit: BoxFit.cover, height: 100.0)
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
