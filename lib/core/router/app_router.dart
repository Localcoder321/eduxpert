import 'package:eduxpert/modules/main_page/presentation/pages/main_page.dart';
import 'package:eduxpert/modules/register_login/presentation/pages/register_page.dart';
import 'package:eduxpert/modules/single_lesson/presentation/pages/single_lesson_page.dart';
import 'package:eduxpert/modules/single_subject/presentation/pages/single_subject_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/main_page', routes: [
  GoRoute(
    path: '/main_page',
    builder: (context, state) => const MainPage(),
  ),
  GoRoute(
    path: '/single_lesson',
    builder: (context, state) {
      final lesson = state.extra as Map<String, String>;
      final lessonName = lesson['name'] ?? "";
      final videoId = lesson['videoId'] ?? "";
      return SingleLessonPage(
        lessonName: lessonName,
        videoId: videoId,
      );
    },
  ),
  GoRoute(
    path: '/single_subject/:subjectName',
    builder: (context, state) {
      final subjectName = state.pathParameters['subjectName'] ?? "";
      return SingleSubjectPage(subjectName: subjectName);
    },
  ),
  GoRoute(
    path: '/register_page',
    builder: (context, state) => const RegisterPage(),
  ),
]);
