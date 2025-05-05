import 'package:get/get.dart';
import '../models/episode_model.dart';

class PodcastDetailsController extends GetxController {
  var episodes = <Episode>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadEpisodes();
  }

  void loadEpisodes() {
    // Embedded JSON data as Dart list
    final List<Map<String, dynamic>> jsonData = [
      {
        "title": "Episode 1",
        "date": "Sun, 4 May 2025 12:00",
        "description":
        "In this conversation, meta-david interviews Sandy Carter from Unstoppable Domains...",
        "duration": "1:20",
        "isPlaying": false,
        "isActive": false
      },
      {
        "title": "Episode 2",
        "date": "Mon, 5 May 2025 1:00",
        "description":
        "meta-david talks with the legendary Gabe Weis, a mixed-media artist living in the Bay Area...",
        "duration": "1:20",
        "isPlaying": false,
        "isActive": false
      },
      {
        "title": "Episode 3",
        "date": "Wed, 1 Jan 2025 3:00",
        "description":
        "Hello, gm gm! This is a trailer episode where we are transitioning from The Dead NFT Artist Society...",
        "duration": "1:20",
        "isPlaying": false,
        "isActive": false
      },
      {
        "title": "Episode 4",
        "date": "Fri, 1 Jan 2025 3:00",
        "description":
        "meta-david talks with the legendary Gabe Weis, a mixed-media artist living in the Artist Society...",
        "duration": "1:20",
        "isPlaying": false,
        "isActive": false
      }
    ];

    episodes.value = jsonData.map((e) => Episode.fromJson(e)).toList();
    isLoading.value = false;
  }

}
