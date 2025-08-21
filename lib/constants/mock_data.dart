import 'package:portfolio/models/achievement.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/project.dart';

class MockData {
  static const List<Achievement> achievements = [
    Achievement(
      title: 'Flutter Hackathon Winner 2023',
      points: [
        'First place in International Flutter Hackathon',
      ],
      image: 'assets/images/about.jpg',
    ),
    Achievement(
      title: 'Google Developer Expert',
      points: [
        'Recognized as Flutter & Dart GDE',
      ],
      image: 'assets/images/about.jpg',
      link: 'https://developers.google.com/community/experts',
    ),
    Achievement(
      title: '1M+ App Downloads',
      points: [
        'Multiple apps with 1M+ combined downloads',
      ],
      image: 'assets/images/about.jpg',
    ),
    Achievement(
      title: 'Open Source Impact',
      points: [
        'Created 10+ popular Flutter packages',
      ],
      image: 'assets/images/about.jpg',
    ),
    Achievement(
      title: 'FlutterCon 2024 Speaker',
      points: [
        'Keynote speaker at FlutterCon 2024',
      ],
      image: 'assets/images/about.jpg',
      link: 'https://fluttercon.dev/2024',
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      companyLogo: 'assets/images/about.jpg',
      companyName: 'Tech Innovators Inc.',
      jobTitle: 'Senior Flutter Developer',
      startDate: 'Jan 2023',
      endDate: 'Present',
      achievements: [
        'Led a team of 5 developers in building a complex e-commerce application using Flutter and Firebase',
        'Implemented state management solutions using BLoC pattern, resulting in 40% improved app performance',
        'Mentored junior developers and established coding standards for the mobile development team'
      ],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.example.app',
      appStoreLink: 'https://apps.apple.com/app/id123456789',
    ),
    Experience(
      companyLogo: 'assets/images/about.jpg',
      companyName: 'Mobile Solutions Ltd.',
      jobTitle: 'Flutter Developer',
      startDate: 'Mar 2021',
      endDate: 'Dec 2022',
      achievements: [
        'Developed and launched 3 successful Flutter applications with over 100K combined downloads',
        'Integrated complex REST APIs and implemented efficient caching mechanisms',
        'Created reusable widget libraries reducing development time by 30%'
      ],
    ),
    Experience(
      companyLogo: 'assets/images/about.jpg',
      companyName: 'Digital Creatives',
      jobTitle: 'Mobile App Developer',
      startDate: 'Jun 2020',
      endDate: 'Feb 2021',
      achievements: [
        'Built responsive and user-friendly mobile applications using Flutter',
        'Collaborated with UI/UX designers to implement pixel-perfect designs',
        'Improved app performance by optimizing resource usage and implementing lazy loading'
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      images: [
        'assets/images/about.jpg',
        'assets/images/about.jpg',
        'assets/images/about.jpg',
      ],
      logo: 'assets/images/about.jpg',
      title: 'E-Commerce App',
      description: 'A full-featured e-commerce application with modern UI and seamless user experience',
      features: [
        'User authentication and profile management',
      ],
      tools: ['Flutter', 'Firebase', 'Stripe', 'GetX'],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.example.ecommerce',
      appStoreLink: 'https://apps.apple.com/app/id987654321',
      githubLink: 'https://github.com/username/ecommerce-app',
    ),
    Project(
      images: [
        'assets/images/about.jpg',
        'assets/images/about.jpg',
        'assets/images/about.jpg',
      ],
      logo: 'assets/images/about.jpg',
      title: 'Social Media App',
      description: 'A modern social networking platform focused on connecting professionals',
      features: [
        'Real-time messaging and notifications',
      ],
      tools: ['Flutter', 'Node.js', 'MongoDB', 'WebSocket'],
      githubLink: 'https://github.com/username/social-app',
    ),
    Project(
      images: [
        'assets/images/about.jpg',
        'assets/images/about.jpg',
      ],
      logo: 'assets/images/about.jpg',
      title: 'Fitness Tracking App',
      description: 'Comprehensive fitness tracking application with personalized workout plans',
      features: [
        'Custom workout plan generation',
      ],
      tools: ['Flutter', 'HealthKit', 'Google Fit', 'Firebase'],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.example.fitness',
      appStoreLink: 'https://apps.apple.com/app/id123456789',
    ),
    Project(
      images: [
        'assets/images/about.jpg',
        'assets/images/about.jpg',
        'assets/images/about.jpg',
      ],
      logo: 'assets/images/about.jpg',
      title: 'Task Management App',
      description: 'Intuitive task management application for teams and individuals',
      features: [
        'Real-time sync across devices',
      ],
      tools: ['Flutter', 'Firebase', 'ML Kit'],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.example.tasks',
      githubLink: 'https://github.com/username/weather-app',
    ),
    Project(
      images: [
        'assets/images/about.jpg',
        'assets/images/about.jpg',
      ],
      logo: 'assets/images/about.jpg',
      title: 'Weather App',
      description: 'Beautiful weather application with detailed forecasts and alerts',
      features: [
        'Real-time weather updates with animations',
      ],
      tools: ['Flutter', 'Weather API', 'Animations'],
      githubLink: 'https://github.com/username/weather-app',
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.example.weather',
    ),
  ];
}
