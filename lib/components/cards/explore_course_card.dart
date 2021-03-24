import 'package:designcode/model/course.dart';
import 'package:flutter/material.dart';
import 'package:designcode/constants.dart';

import 'package:firebase_storage/firebase_storage.dart';

class ExploreCourseCard extends StatefulWidget {
  ExploreCourseCard({@required this.course}); //initialization manually define

  final Course course;

  @override
  _ExploreCourseCardState createState() => _ExploreCourseCardState();
}

class _ExploreCourseCardState extends State<ExploreCourseCard> {
  final _storage = FirebaseStorage.instance;
  String illustrationURL;

  @override
  void initState() {
    super.initState();
    getIllustration();
  }

  void getIllustration() {
    _storage
        .ref("illustrations/${widget.course.illustration}")
        .getDownloadURL()
        .then((url) {
      setState(() {
        illustrationURL = url;
      });
    });
  }

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
            decoration: BoxDecoration(gradient: widget.course.background),
            child: Padding(
              padding: EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Expanded(
                    //content in card
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.course.courseSubtitle,
                          style: kCardSubtitleStyle,
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          widget.course.courseTitle,
                          style: kCardTitleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    // image of the widget
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (illustrationURL == null)
                          ? Container()
                          : Image.network(
                              illustrationURL,
                              fit: BoxFit.cover,
                              height: 100.0,
                            ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
