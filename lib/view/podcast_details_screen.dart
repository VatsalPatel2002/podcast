import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/controllers/podcast_details_controller.dart';
import 'package:podcast_app/routes/app_routes.dart';
import '../models/episode_model.dart';

class PodcastDetailsScreen extends StatelessWidget {
  PodcastDetailsScreen({super.key});

  static const routeName = '/podcast-details-screen';

  final controller = Get.put(PodcastDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F143A), Color(0xFF0C0545)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white10,
                        backgroundImage: AssetImage('assets/img2.png'),
                      )
                    ],
                  ),
                  Expanded(child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/img1.png',
                              height: 160,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "The Blockchain Experience",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Text("Media3 Labs LLC",
                            style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Text(
                          "Welcome to The Blockchain Experience, a podcast hosted by meta-david, where we dive deep into the world of blockchain technology including, web3, NFTs, and decentralized systems...",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        const Text("Wed, 11 Jan 2023 9:00 PM",
                            style: TextStyle(color: Colors.white38, fontSize: 13)),
                        const SizedBox(height: 24),
                        const Text("Available episodes",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.episodes.length,
                          itemBuilder: (ctx, index) {
                            final ep = controller.episodes[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: buildEpisodeCard(ep),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildEpisodeCard(Episode episode) {
    return GestureDetector(
      onTap: (){
          Get.toNamed(
            RouteManager.getPodcastPlayerScreen(),
            arguments: episode,
          );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6748FF), Color(0xFFC19E8E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: episode.isActive ? const Color(0xFF212159) : const Color(0xFF212159),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(children: []),
                ],
              ),
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                episode.date,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                episode.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    episode.isPlaying ? Icons.pause_circle : Icons.play_circle_fill,
                    color: episode.isPlaying ? Colors.pinkAccent : Colors.white,
                    size: 30,
                  ),
                  const Spacer(),
                  Text(
                    episode.duration,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
