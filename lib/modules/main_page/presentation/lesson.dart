class Lesson {
  final String title;
  final String description;
  final String videoId;

  Lesson({
    required this.title,
    required this.description,
    required this.videoId,
  });

  // Factory method to create a Lesson from a map
  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'],
      description: map['description'],
      videoId: map['videoId'] ?? '', // Handle videoId being null
    );
  }

  // Method to convert a Lesson to a map (useful for saving or sending data)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'videoId': videoId,
    };
  }
}