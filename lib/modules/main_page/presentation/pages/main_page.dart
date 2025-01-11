import 'package:eduxpert/modules/main_page/presentation/widgets/custom_drawer.dart';
import 'package:eduxpert/modules/main_page/presentation/widgets/custom_subject.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> subjects = [
    {
      "subjectName": "Mathematics",
      "lessonCount": 12,
    },
    {
      "subjectName": "English",
      "lessonCount": 10,
    },
    {
      "subjectName": "History",
      "lessonCount": 6,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(builder: (BuildContext context) {
              return Row(
                children: [
                  const Text(
                    "Hello User!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Scaffold.of(context).openEndDrawer();
                      });
                    },
                    child: const Icon(
                      Icons.menu_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            const Text(
              "Here are your subjects to prepare for WIUT:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            //const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/single_subject/${subject['subjectName']}');
                    },
                    child: CustomSubject(
                      subjectName: subject['subjectName'],
                      lessonCount: subject['lessonCount'],
                      icon: "",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
