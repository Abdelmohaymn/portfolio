class Achievement {
  final String title;
  final List<String> points;
  final String image;
  final String? link;

  const Achievement({
    required this.title,
    required this.points,
    required this.image,
    this.link,
  });
}
