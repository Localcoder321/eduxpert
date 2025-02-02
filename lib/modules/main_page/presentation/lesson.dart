class Lesson {
  final String title;
  final String description;
  final String videoId;
  final List<Map<String, String>> materials;

  Lesson({
    required this.title,
    required this.description,
    required this.videoId,
    this.materials = const [],
  });

  // Factory method to create a Lesson from a map
  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'],
      description: map['description'],
      videoId: map['videoId'] ?? '', // Handle videoId being null
      materials: List<Map<String, String>>.from(map['materials']),
    );
  }

  // Method to convert a Lesson to a map (useful for saving or sending data)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'videoId': videoId,
      'materials':
          materials.map((item) => Map<String, String>.from(item)).toList(),
    };
  }
}
