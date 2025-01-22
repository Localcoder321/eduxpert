import 'package:eduxpert/assets/constants/app_icons.dart';
import 'package:eduxpert/modules/main_page/presentation/lesson.dart';
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
      "icon": AppIcons.calculator,
      "lessons": [
        {
          "title": "Basic Algebra",
          "description":
              "Understand the foundational concepts of algebra, such as variables, constants, and expressions. Practice forming and solving simple equations, and learn how algebra applies to everyday problem-solving.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Linear Equations",
          "description":
              "Explore single-variable and multi-variable linear equations. Learn techniques like substitution and elimination to find solutions, and visualize equations as straight lines on a graph.",
          "videoId": "fmVDXW21qSo",
        },
        {
          "title": "Quadratic Functions",
          "description":
              "Dive into quadratic equations and learn about their properties, such as roots, vertex, and axis of symmetry. Practice graphing parabolas and solving problems using methods like factorization, completing the square, and the quadratic formula.",
          "videoId": "hkmRI-gPSLQ",
        },
        {
          "title": "Polynomials",
          "description":
              "Study polynomial expressions and their operations, including addition, subtraction, multiplication, and division. Learn techniques for factorization and solving polynomial equations, with a focus on real-world applications.",
          "videoId": "Z2QgF26DYeo",
        },
        {
          "title": "Trigonometry Basics",
          "description":
              "Gain an understanding of angles, triangles, and trigonometric functions like sine, cosine, and tangent. Learn to solve problems involving right triangles and apply these concepts to real-world scenarios.",
          "videoId": "Ss8lkI-7Qc8",
        },
        {
          "title": "Geometry Foundations",
          "description":
              "Learn the basic principles of geometry, including points, lines, angles, and shapes. Explore properties of triangles, quadrilaterals, and circles, and solve problems using theorems like Pythagoras' theorem.",
          "videoId": "BPk1uJ4txPc",
        },
        {
          "title": "Probability and Statistics",
          "description":
              "Study the fundamentals of probability, including events, outcomes, and probabilities of single and combined events. Learn to interpret and represent data using charts, graphs, and statistical measures like mean, median, and mode.",
          "videoId": "_HbEl-2n5AQ",
        },
        {
          "title": "Introduction to Calculus",
          "description":
              "Get an overview of calculus concepts such as limits, derivatives, and integrals. Understand their significance in measuring change and solving real-world problems, preparing you for advanced topics.",
          "videoId": "cnJ2GKQN-28",
        },
        {
          "title": "Coordinate Geometry",
          "description":
              "Explore plotting points, lines, and curves on a coordinate plane. Learn to find equations of lines, distances between points, and midpoints, with practical applications in real-life scenarios.",
          "videoId": "cnJ2GKQN-28",
        },
        {
          "title": "Mensuration",
          "description":
              "Calculate areas, perimeters, and volumes of 2D and 3D shapes such as triangles, circles, cylinders, and spheres. Understand formulas and their applications in solving measurement-related problems.",
          "videoId": "cnJ2GKQN-28",
        },
        {
          "title": "Set Theory",
          "description":
              "Learn about sets, subsets, unions, intersections, and complements. Use Venn diagrams to visualize and solve problems involving relationships between different groups.",
          "videoId": "cnJ2GKQN-28",
        },
        {
          "title": "Number Systems",
          "description":
              "Explore various types of numbers, including integers, fractions, decimals, and irrational numbers. Understand their properties and operations, and learn how to convert between different number forms.",
          "videoId": "cnJ2GKQN-28",
        },
      ],
    },
    {
      "subjectName": "English",
      "lessonCount": 10,
      "icon": AppIcons.english,
      "lessons": [
        {
          "title": "Introduction to Grammar",
          "description":
              "This lesson lays the foundation for understanding English grammar. You will learn about sentence structure, parts of speech (nouns, verbs, adjectives, adverbs, etc.), and their roles in constructing meaningful sentences. Examples and exercises will help reinforce the rules of grammar.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Tenses Overview",
          "description":
              "Delve into the world of tenses and understand how to express time. This lesson covers past, present, and future tenses, along with their variations like simple, continuous, perfect, and perfect continuous. You'll practice forming sentences and identifying tense usage in daily communication.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Building Vocabulary",
          "description":
              "Expand your knowledge of English words, phrases, and their meanings. Learn techniques like root analysis, synonyms, antonyms, and contextual usage to strengthen your vocabulary. This lesson includes activities like word association games and creating sentences.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Writing Essays",
          "description":
              "Learn how to write compelling essays with a clear structure. This lesson covers creating introductions that grab attention, body paragraphs that present arguments logically, and conclusions that leave a lasting impression. You'll practice different types of essays, such as narrative, descriptive, and persuasive.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Reading Comprehension",
          "description":
              "Develop your ability to extract key information from written texts. Learn strategies like skimming, scanning, and identifying main ideas and supporting details. Practice answering questions based on passages, improving both speed and accuracy.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Speaking Practice",
          "description":
              "Improve your spoken English through pronunciation drills, conversational practice, and role-playing exercises. This lesson focuses on building fluency, reducing accents, and expressing ideas clearly in real-world scenarios.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Listening Skills",
          "description":
              "Hone your listening abilities by working with audio clips, podcasts, and conversations. Learn to identify key points, interpret emotions, and understand different accents. This lesson helps you respond accurately to spoken English in various contexts.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Punctuation and Sentence Structure",
          "description":
              "Master the use of punctuation marks like commas, periods, colons, and semicolons to create polished writing. Learn how to construct sentences with proper syntax, ensuring clarity and flow in your communication.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Idioms and Phrases",
          "description":
              "Explore commonly used idioms and phrases to add depth and naturalness to your language. Learn their meanings, origins, and how to use them effectively in both formal and informal conversations.",
          "videoId": "YPoU85YGwG4",
        },
        {
          "title": "Consolidating Skills",
          "description":
              "Focus on integrating all aspects of language learning into practical use. Engage in real-world scenarios like writing emails, participating in conversations, or analyzing written content. Strengthen your grammar, writing, speaking, and listening skills through guided activities that build confidence and fluency.",
          "videoId": "YPoU85YGwG4",
        },
      ],
    },
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
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    subjects.length,
                    (index) {
                      final subject = subjects[index];
                      final lessons = (subject['lessons'] as List)
                          .map((lessonData) => Lesson.fromMap(lessonData))
                          .toList();
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            '/single_subject/${subject['subjectName']}',
                            extra: lessons,
                          );
                        },
                        child: CustomSubject(
                          subjectName: subject['subjectName'],
                          lessonCount: subject['lessonCount'],
                          icon: subject['icon'],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
