class Experience {
  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String startDate;
  final String endDate;
  final List<String> achievements;
  final String? googlePlayLink;
  final String? appStoreLink;

  const Experience({
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    required this.achievements,
    this.googlePlayLink,
    this.appStoreLink,
  });
}
