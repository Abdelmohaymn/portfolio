import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/sections/hero/hero_section.dart';
import 'package:portfolio/sections/about/about_section.dart';
import 'package:portfolio/sections/experience/experience_section.dart';
import 'package:portfolio/sections/projects/projects_section.dart';
import 'package:portfolio/sections/achievements/achievements_section.dart';
import 'package:portfolio/sections/contact/contact_section.dart';
import 'package:portfolio/widgets/navigation_bar.dart';
import 'package:portfolio/constants/index.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _showButtons = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigationBar(
        onSelected: scrollToSection,
      ),
      floatingActionButton: _showButtons ? Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              heroTag: 'whatsapp',
              onPressed: () {
                // TODO: Add WhatsApp link
              },
              backgroundColor: AppColors.scaffoldBackground,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.store, color: Colors.white),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              heroTag: 'scroll_top',
              onPressed: _scrollToTop,
              backgroundColor: AppColors.scaffoldBackground,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ) : null,
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyPress,
        child: PrimaryScrollController(
          controller: _scrollController,
          child: RawScrollbar(
            controller: _scrollController,
            thumbColor: AppColors.primary.withValues(alpha: 77), // 0.3 * 255
            trackColor: AppColors.cardBorder,
            thickness: 8,
            radius: const Radius.circular(4),
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    key: _sectionKeys['home'],
                    child: const HeroSection(),
                  ),
                  Container(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),
                  Container(
                    key: _sectionKeys['experience'],
                    child: const ExperienceSection(),
                  ),
                  Container(
                    key: _sectionKeys['projects'],
                    child: const ProjectsSection(),
                  ),
                  Container(
                    key: _sectionKeys['achievements'],
                    child: const AchievementsSection(),
                  ),
                  Container(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}