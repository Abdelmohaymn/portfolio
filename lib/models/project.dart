class Project {
  final List<String> images;
  final String logo;
  final String title;
  final String description;
  final List<String> features;
  final List<String>? tools;
  final String? googlePlayLink;
  final String? appStoreLink;
  final String? githubLink;

  const Project({
    required this.images,
    required this.logo,
    required this.title,
    required this.description,
    required this.features,
    this.tools,
    this.googlePlayLink,
    this.appStoreLink,
    this.githubLink,
  });
}
