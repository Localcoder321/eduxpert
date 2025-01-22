import 'package:eduxpert/globals/widgets/custom_lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleLessonPage extends StatefulWidget {
  final String title;
  final String videoId;
  final String description;
  const SingleLessonPage({
    super.key,
    required this.title,
    required this.videoId,
    required this.description,
  });

  @override
  State<SingleLessonPage> createState() => _SingleLessonPageState();
}

class _SingleLessonPageState extends State<SingleLessonPage> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: false,
        showLiveFullscreenButton: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        actionsPadding: EdgeInsets.zero,
      ),
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ],
        );
      },
      builder: (context, player) {
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
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: player,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Description of the lesson",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Materials which may be useful for this lesson:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const CustomLessonCard(text: "Material 1 from internet link"),
                const CustomLessonCard(
                    text: "Material 2 from internet in PDF format"),
              ],
            ),
          ),
        );
      },
    );
  }
}
