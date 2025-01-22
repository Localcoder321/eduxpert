import 'package:eduxpert/globals/widgets/custom_lesson_card.dart';
import 'package:eduxpert/modules/main_page/presentation/lesson.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SingleSubjectPage extends StatelessWidget {
  final String subjectName;
  final List<Lesson> lessons;
  const SingleSubjectPage(
      {super.key, required this.subjectName, required this.lessons});

  @override
  Widget build(BuildContext context) {

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
                text: "Lesson ${index + 1} - ${lesson.title}",
              ),
            );
          },
        ),
      ),
    );
  }
}
