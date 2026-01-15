import 'package:portfolio/models/achievement.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/project.dart';

class MockData {

  static const List<Experience> experiences = [
    Experience(
      companyLogo: 'assets/company/isagha.jpg',
      companyName: 'iSagha',
      jobTitle: 'Mobile Developer',
      startDate: 'Sep 2024',
      endDate: 'Apr 2025',
      achievements: [
        '#iSagha# is an e-commerce platform for buying and selling precious minerals like gold and silver.',
        'Integrated in-app subscriptions using #RevenueCat#',
        'Implemented new features and refactored existing code',
        'Collaborated with backend team and followed #agile# practices using #Trello#',
        'The app has #500K+# downloads on Play Store and App Store'
      ],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=com.isagha.android.apps.main&hl=en',
      appStoreLink: 'https://apps.apple.com/us/app/isagha/id1147225883',
    ),
    Experience(
      companyLogo: 'assets/company/sherkety.jpeg',
      companyName: 'Sherkety',
      jobTitle: 'Mobile developer (Intern)',
      startDate: 'Jul 2024',
      endDate: 'Aug 2024',
      achievements: [
        '#Sherkety# is an innovative startup hub in Egypt designed to simplify the process of starting and managing businesses.',
        'Developing and maintaining the #Sherkety# app using #Flutter# and #Firebase#, focusing on modular architecture, state management with #Riverpod#, and creating reusable UI components.',
      ],
    ),
    Experience(
      companyLogo: 'assets/company/scaleai.jpg',
      companyName: 'Scale AI ',
      jobTitle: 'Coder',
      startDate: 'Aug 2023',
      endDate: 'Apr 2024',
      achievements: [
        '#Scale AI# is an artificial intelligence company which provides labeled data used to train AI applications.',
        'Evaluated chatbot responses for accuracy across coding queries in C++, Java, and Python.',
        'Provided detailed feedback on response quality, ensuring correctness and relevance, contributing to an improvement in chatbot performance.',
        'Provided solutions, tutorials, and problem summaries for a wide range of programming challenges (e.g., #Codeforces# problems) to support the #Dolphin LLM’s development#.'
      ],
    ),
    Experience(
      companyLogo: 'assets/company/iti.jpeg',
      companyName: 'Information Technology Institute',
      jobTitle: 'Android Development Trainee',
      startDate: 'Jul 2023',
      endDate: 'Sep 2023',
      achievements: [
        'Completed the #Android Development Track# at #ITI#, gaining hands-on training in #native Android#, #Kotlin#, and modern mobile development practices.',
        ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      images: [
        'assets/projects/shaghlni_1.png',
      ],
      logo: 'assets/projects_logos/shaghlni.png',
      title: 'Shaghalni',
      description: 'A mobile app for connecting job seekers and companies',
      features: [
        'role-based accounts',
        'payments',
        'real-time chat',
      ],
      tools: ['Flutter', 'copilot ai', ],
      googlePlayLink: 'https://play.google.com/store/apps/details?id=sa.shaghalni',
      appStoreLink: 'https://apps.apple.com/us/app/%D8%B4%D8%BA%D9%84%D9%86%D9%8A-%D9%88%D8%B3%D9%8A%D8%B7%D9%83-%D9%84%D9%84%D9%85%D9%82%D8%A7%D9%88%D9%84%D8%A7%D8%AA/id6742157065',
    ),
    Project(
      images: [
        'assets/projects/pety_1.png',
        'assets/projects/pety_2.png',
      ],
      logo: 'assets/projects_logos/pety.png',
      title: 'Pety',
      description: 'A mobile app that connects pet owners with vets, groomers, and sitters',
      features: [
        'chatbot',
        'dashboards',
        'community',
        'booking'
      ],
      tools: ['Flutter' ],
      githubLink: 'https://github.com/Abdelmohaymn/Pety'
    ),
    Project(
        images: [
          'assets/projects/tasky_1.png',
        ],
        logo: 'assets/projects_logos/tasky.png',
        title: 'Tasky',
        description: 'A mobile app for managing daily tasks with authentication and simple organization tools',
        features: [
          'Authentication',
          'QR',
          'Tasks',
          'Refresh Token'
        ],
        tools: ['Flutter' ],
        githubLink: 'https://github.com/Abdelmohaymn/todo_task'
    ),
    Project(
        images: [
          'assets/projects/social_1.png',
          'assets/projects/social_2.png',
          'assets/projects/social_3.png',
        ],
        logo: 'assets/projects_logos/social.png',
        title: 'Social',
        description: 'A simple social-style app',
        features: [
          'Posts',
          'Comments',
          'Chat',
        ],
        tools: ['Flutter' , 'Firebase'],
        githubLink: 'https://github.com/Abdelmohaymn/first_flutter'
    ),
    Project(
        images: [
          'assets/projects/fast_food_1.png',
          'assets/projects/fast_food_2.png',
          'assets/projects/fast_food_3.png',
          'assets/projects/fast_food_4.png',
        ],
        logo: 'assets/projects_logos/fast_food.png',
        title: 'Fast Food',
        description: 'A recipe app that fetches diverse meals from Spoonacular API',
        features: [
          'local db',
          'search',
          'handle offline',
        ],
        tools: ['Kotlin', 'Room db', 'Coroutines'],
        githubLink: 'https://github.com/Abdelmohaymn/Fast_Food'
    ),
    Project(
        images: [],
        logo: 'assets/projects_logos/ai_cam.png',
        title: 'Object Detection Camera',
        description: 'An AI-powered camera app that detects objects and automatically zooms in when a dog or cat is recognized.',
        features: [
          'Object Detection', 'Auto-Zoom'
        ],
        tools: ['Flutter', 'Camera', 'TFLite'],
        githubLink: 'https://github.com/Abdelmohaymn/camera_app_with_AI'
    ),
    Project(
        images: [],
        logo: 'assets/projects_logos/face_cam.png',
        title: 'Face Detection',
        description: 'Real-time face detection app',
        features: [
          'Detection', 'Overlay', 'Capture'
        ],
        tools: ['Kotlin', 'CameraX', 'TensorFlow Lite'],
        githubLink: 'https://github.com/Abdelmohaymn/face_detection'
    ),
    Project(
        images: [
          'assets/projects/note_1.png',
        ],
        logo: 'assets/projects_logos/note.png',
        title: 'Note',
        description: 'A basic note-taking app with add, edit, and delete functionality',
        features: [
          'CRUD Operations',
        ],
        tools: ['Kotlin', 'Room db', 'MVVM'],
        githubLink: 'https://github.com/Abdelmohaymn/simple_note_app'
    ),
    Project(
        images: [
          'assets/projects/weather_1.png',
        ],
        logo: 'assets/projects_logos/weather.png',
        title: 'Weather',
        description: 'A mobile app that shows current and forecasted weather for any city.',
        features: [
          'Weather'
          'Forecasts',
          'Location'
          'Dark Mode'
        ],
        tools: ['Java', 'Retrofit'],
        githubLink: 'https://github.com/Abdelmohaymn/Weather-App'
    ),
  ];

  static const List<Achievement> achievements = [
    Achievement(
      title: 'Meta Hacker Cup (2025)',
      points: [
        'Achieved Global Rank #1200 (Prize Winner)#.',
        'awarded exclusive #T-shirt# for top-tier performance among thousands of international competitors.',
      ],
      image: 'assets/achievements/meta_hacker_cup_2025.png',
    ),
    Achievement(
      title: 'Egypt IoT & AI Challenge (2024)',
      points: [
        'Ranked among the #Top 25 nationwide projects# with graduation project #Pety#.',
      ],
      image: 'assets/achievements/iot.png',
    ),
    Achievement(
      title: 'Made in Egypt (MiE) Competition (2024)',
      points: [
        'Secured a position in the #Top 48 graduation projects# nationwide with graduation project #Pety#.',
      ],
      image: 'assets/achievements/mie.png',
    ),
    Achievement(
      title: 'ACM ACPC Contest (2023)',
      points: [
        'Qualified to the prestigious #ACM Arab Collegiate Programming Contest (ACPC)# in the MENA region.',
        'Ranked #51st# place in #ECPC 2023# among #200+# teams.',
      ],
      image: 'assets/achievements/acpc.jpg',
    ),
    Achievement(
      title: 'IEEE Xtreme 16.0 (2022)',
      points: [
        'Achieved #10th place in Egypt# and #138th place globally#.',
      ],
      image: 'assets/achievements/ieee.png',
    ),
    Achievement(
      title: 'CodeChef – Problem Author (2024)',
      points: [
        'Authored the competitive programming problem %The Smallest String% *$codechefProblem*',
      ],
      image: 'assets/achievements/codechef.png',
    ),
    Achievement(
      title: 'Technical Member – ICPC Mansoura Community',
      points: [
        'Mentored students in #problem-solving strategies# and competitive programming',
        'Designed and curated challenging programming problems for local contests '
      ],
      image: 'assets/achievements/mansoura.jpg',
    ),
    Achievement(
      title: 'Judge – ACM ECPC Qualification Round (2024)',
      points: [
        'Served as a #judge# evaluating solutions during the qualification stage of the ACM ECPC competition.',
      ],
      image: 'assets/achievements/judge.jpg',
    ),
    Achievement(
      title: 'Technical Skills in Competitive Programming',
      points: [
        'Solved #3000+# problems across multiple competitive programming platforms including %Codeforces% *$codeforcesValue* (#1350+# problems) and %LeetCode% *$leetcodeValue* (#870+# problems), along with #CodeChef#, #AtCoder#, #CodinGame#, #HackerRank#, and others, demonstrating mastery of #algorithms and data structures#.'
      ],
      image: 'assets/achievements/comp.png',
    ),
  ];

  // Hero Section Stats
  static const String heroTitle = '📱 Mobile Software Engineer';
  static const String heroSubtitle = 'Building high-quality mobile apps with seamless user experiences';
  static const String projectsCount = '15+';
  static const String publishedAppsCount = '3+';
  static const String experienceYearsCount = '1+';

  // about section
  static const String aboutDescription = 'I’m #Abdelmohaymn Albashier#, a #Software Engineer# passionate about building impactful mobile applications. Skilled in #Flutter# and #Android#, I’ve developed and published apps like #iSagha#, #Shaghalni#, and #Pety#, focusing on clean architecture and smooth user experiences.';
  static const String aboutHighlights = 'I’ve gained hands-on experience through #full-time# and #internship# roles, working with #agile# teams, integrating modern tools, and enhancing app performance.';
  static const String aboutHighlights2 = 'Beyond development, I’m an active #problem solver# on platforms like #Codeforces# and #LeetCode#, and a proud ICPC competitor, having qualified for the #ACPC# MENA regional contest and ranked #10th# in Egypt at #IEEE Xtreme 16#.';

  // contact section
  static const String emailValue = 'abdelmohaymn.career@gmail.com';
  static const String phoneValue = '+201203890786';
  static const String linkedInValue = 'https://www.linkedin.com/in/abdelmohaymn-albashier-4146b0235/';
  static const String githubValue = 'https://github.com/Abdelmohaymn';
  static const String leetcodeValue = 'https://leetcode.com/u/abdelmohaymn';
  static const String codeforcesValue = 'https://codeforces.com/profile/Abdelmohaymn';
  static const String codechefProblem = 'https://www.codechef.com/problems/ABDELMOHAYMN';

}
