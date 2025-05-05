import 'package:get/get.dart';
import 'package:podcast_app/view/podcast_details_screen.dart';
import 'package:podcast_app/view/podcast_player_screen.dart';

class RouteManager {

  static String getPodcastDetailsScreen() => PodcastDetailsScreen.routeName;
  static String getPodcastPlayerScreen() => PodcastPlayerScreen.routeName;

  static List<GetPage> appRoutes = [
    GetPage(name: PodcastDetailsScreen.routeName, page: () => PodcastDetailsScreen(),),
    GetPage(name: PodcastPlayerScreen.routeName, page: () => PodcastPlayerScreen(),)
  ];
}