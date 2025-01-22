import 'package:eduxpert/modules/main_page/presentation/pages/main_page.dart';
import 'package:eduxpert/modules/profile/presentation/pages/profile_page.dart';
import 'package:eduxpert/modules/profile/presentation/pages/subscription_page.dart';
import 'package:eduxpert/modules/profile/presentation/pages/subscriptions_page.dart';
import 'package:eduxpert/modules/register_login/presentation/pages/register_page.dart';
import 'package:eduxpert/modules/single_lesson/presentation/pages/single_lesson_page.dart';
import 'package:eduxpert/modules/single_subject/presentation/pages/single_subject_page.dart';
import 'package:eduxpert/modules/uni_selection_pages/presentation/pages/gov_uni_selection_page.dart';
import 'package:eduxpert/modules/uni_selection_pages/presentation/pages/uni_selection_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/register_page', routes: [
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
  GoRoute(
    path: '/subscription_page',
    builder: (context, state) => const SubscriptionPage(),
  ),
  GoRoute(
    path: '/subscriptions_page',
    builder: (context, state) => const SubscriptionsPage(),
  ),
  GoRoute(
    path: '/profile_page',
    builder: (context, state) => const ProfilePage(),
  ),
  GoRoute(
    path: '/uni_selection_page',
    builder: (context, state) => const UniSelectionPage(),
  ),
  GoRoute(
    path: '/gov_uni_selection_page',
    builder: (context, state) => const GovUniSelectionPage(),
  ),
]);
