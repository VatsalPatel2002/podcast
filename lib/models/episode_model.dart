class Episode {
  final String title;
  final String date;
  final String description;
  final String duration;
  final bool isPlaying;
  final bool isActive;

  Episode({
    required this.title,
    required this.date,
    required this.description,
    required this.duration,
    required this.isPlaying,
    required this.isActive,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      title: json['title'],
      date: json['date'],
      description: json['description'],
      duration: json['duration'],
      isPlaying: json['isPlaying'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,

    );
  }
}
