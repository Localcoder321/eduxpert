import 'package:eduxpert/globals/widgets/custom_lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SingleSubjectPage extends StatelessWidget {
  final String subjectName;
  const SingleSubjectPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lessons = [
      {"name": "Plus and Minus", "videoId": "YPoU85YGwG4"},
      {"name": "Divide", "videoId": "fmVDXW21qSo"},
      {"name": "Multiply", "videoId": "hkmRI-gPSLQ"},
      {"name": "Fractions", "videoId": "Z2QgF26DYeo"},
      {"name": "Equations", "videoId": "Ss8lkI-7Qc8"},
      {"name": "Geometry", "videoId": "BPk1uJ4txPc"},
      {"name": "Trigonometry", "videoId": "_HbEl-2n5AQ"},
      {
        "name": "Algebra and Geometry as different modules in math",
        "videoId": "cnJ2GKQN-28"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          subjectName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: ListView.builder(
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return GestureDetector(
              onTap: () => context.push(
                '/single_lesson',
                extra: lesson,
              ),
              child: CustomLessonCard(
                text: "Lesson ${index + 1} - ${lesson["name"]}",
              ),
            );
          },
        ),
      ),
    );
  }
}
