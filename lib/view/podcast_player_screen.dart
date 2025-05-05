import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_app/models/episode_model.dart';
import 'package:get/get.dart';

class PodcastPlayerScreen extends StatefulWidget {
  const PodcastPlayerScreen({super.key});
  static const routeName = '/podcast-player-screen';

  @override
  State<PodcastPlayerScreen> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  late AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setup();
  }

  Future<void> _setup() async {
    final Episode episode = Get.arguments as Episode;
    try {
      await _audioPlayer.setUrl("https://www.bb.i-nextgen.com/public/upload/songs/audio/audio_1737584691_1.mp3");
      _audioPlayer.positionStream.listen((pos) {
        setState(() {
          _position = pos;
        });
      });
      _audioPlayer.durationStream.listen((dur) {
        if (dur != null) {
          setState(() {
            _duration = dur;
          });
        }
      });
      _audioPlayer.playerStateStream.listen((state) {
        setState(() {
          _isPlaying = state.playing;
        });
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Episode episode = Get.arguments as Episode;

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
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const CircleAvatar(backgroundImage: AssetImage('assets/img2.png')),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.white10,
                      child: Icon(Icons.send, color: Colors.white),
                    )
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/img1.png', height: 280, width: 250),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "The Blockchain Experience",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("Media3 Labs LLC", style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          episode.description,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Playback Controls
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [Colors.purple, Colors.red],
                                    ),
                                  ),
                                  width: double.infinity,
                                ),
                                Positioned(
                                  left: (_position.inSeconds / (_duration.inSeconds == 0 ? 1 : _duration.inSeconds)) *
                                      MediaQuery.of(context).size.width * 0.92,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(_position), style: const TextStyle(color: Colors.white60)),
                                DropdownButton<double>(
                                  value: _audioPlayer.speed,
                                  dropdownColor: const Color(0xFF1C1C4D),
                                  style: const TextStyle(color: Colors.white),
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                  onChanged: (value) {
                                    if (value != null) {
                                      _audioPlayer.setSpeed(value);
                                    }
                                  },
                                  items: [0.5, 1.0, 1.25, 1.5, 2.0].map((speed) {
                                    return DropdownMenuItem(
                                      value: speed,
                                      child: Text('${speed}x'),
                                    );
                                  }).toList(),
                                ),
                                Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white60)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.replay_10, color: Colors.white, size: 30),
                                  onPressed: () => _audioPlayer.seek(_position - const Duration(seconds: 10)),
                                ),
                                const SizedBox(width: 30),
                                IconButton(
                                  icon: Icon(
                                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                  onPressed: () async {
                                    if (_isPlaying) {
                                      await _audioPlayer.pause();
                                    } else {
                                      await _audioPlayer.play();
                                    }
                                  },
                                ),
                                const SizedBox(width: 30),
                                IconButton(
                                  icon: const Icon(Icons.forward_10, color: Colors.white, size: 30),
                                  onPressed: () => _audioPlayer.seek(_position + const Duration(seconds: 10)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C4D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset('assets/img1.png', height: 45, width: 45, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "The Blockchain Experience",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    episode.title,
                                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_isPlaying) {
                                  await _audioPlayer.pause();
                                } else {
                                  await _audioPlayer.play();
                                }
                              },
                              child: Icon(
                                _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                color: Colors.pinkAccent,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
