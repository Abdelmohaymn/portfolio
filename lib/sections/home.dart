import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/sections/hero/hero_section.dart';
import 'package:portfolio/sections/about/about_section.dart';
import 'package:portfolio/sections/experience/experience_section.dart';
import 'package:portfolio/sections/projects/projects_section.dart';
import 'package:portfolio/sections/achievements/achievements_section.dart';
import 'package:portfolio/sections/contact/contact_section.dart';
import 'package:portfolio/widgets/navigation_bar.dart';
import 'package:portfolio/constants/index.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _showButtons = false;
  String _currentSection = 'home';

  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'achievements': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showButtons = _scrollController.offset > 100;
    if (showButtons != _showButtons) {
      setState(() => _showButtons = showButtons);
    }
    _updateCurrentSection();
  }

  void _updateCurrentSection() {
    if (!mounted || _sectionKeys.isEmpty) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;
    String newSection = 'home';
    double minDistance = double.infinity;

    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      final sectionId = entry.key;

      if (key.currentContext != null) {
        try {
          final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollOffset;

          final distance = (sectionTop - scrollOffset).abs();

          if (distance < minDistance && sectionTop <= scrollOffset + viewportHeight * 0.6) {
            minDistance = distance;
            newSection = sectionId;
          }
        } catch (e) {
          continue;
        }
      }
    }

    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  void scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: AppDimensions.scrollAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: AppDimensions.scrollAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  bool _handleKeyPress(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _scrollController.animateTo(
        _scrollController.offset - 100,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _scrollController.animateTo(
        _scrollController.offset + 100,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.pageUp) {
      _scrollController.animateTo(
        _scrollController.offset - MediaQuery.of(context).size.height,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.pageDown) {
      _scrollController.animateTo(
        _scrollController.offset + MediaQuery.of(context).size.height,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.home) {
      _scrollToTop();
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.end) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return true;
    }

    return false;
  }

  // Mobile Coming Soon View
  Widget _buildMobileComingSoon() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gradientStart.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/about.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.gradientStart, AppColors.gradientEnd],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Coming Soon Text
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Description Text
              Text(
                'Mobile version is not ready yet.\nPlease visit on desktop for the full experience.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Animated Loading Indicator
              SizedBox(
                width: 200,
                height: 4,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.gradientStart,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Working on it...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Desktop Portfolio View
  Widget _buildDesktopPortfolio() {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyPress,
      child: Scaffold(
        body: Stack(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.dragged)) {
                      return AppColors.gradientEnd;
                    }
                    if (states.contains(MaterialState.hovered)) {
                      return AppColors.gradientStart;
                    }
                    return AppColors.gradientStart.withOpacity(0.8);
                  }),
                  trackColor: MaterialStateProperty.all(Colors.transparent),
                  thickness: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.dragged) ||
                        states.contains(MaterialState.hovered)) {
                      return 12.0;
                    }
                    return 8.0;
                  }),
                  radius: const Radius.circular(6),
                ),
              ),
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HeroSection(
                        key: _sectionKeys['home'],
                        onViewWorkPressed: () => scrollToSection('projects'),
                      ),
                      AboutSection(key: _sectionKeys['about']),
                      ExperienceSection(key: _sectionKeys['experience']),
                      ProjectsSection(key: _sectionKeys['projects']),
                      AchievementsSection(key: _sectionKeys['achievements']),
                      ContactSection(key: _sectionKeys['contact']),
                    ],
                  ),
                ),
              ),
            ),
            CustomNavigationBar(
              onSelected: scrollToSection,
              currentSection: _currentSection,
            ),
            if (_showButtons) ...[
              Positioned(
                bottom: 24,
                left: 24,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          String url = 'https://wa.me/${MockData.phoneValue}';
                          final uri = Uri.parse(url);
                          try {
                            if (await url_launcher.canLaunchUrl(uri)) {
                              await url_launcher.launchUrl(uri);
                            }
                          } catch (e) {
                            debugPrint('Could not launch $url: $e');
                          }
                        },
                        splashColor: Colors.white.withOpacity(0.3),
                        highlightColor: Colors.white.withOpacity(0.1),
                        child: Container(
                          width: 56,
                          height: 56,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/whatsapp.svg',
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _scrollToTop,
                        splashColor: Colors.white.withOpacity(0.3),
                        highlightColor: Colors.white.withOpacity(0.1),
                        child: Container(
                          width: 56,
                          height: 56,
                          child: const Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if screen width is mobile (typically < 768px)
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      return SelectionArea(child: _buildMobileComingSoon());
    } else {
      return SelectionArea(child: _buildDesktopPortfolio());
    }
  }
}