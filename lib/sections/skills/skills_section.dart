import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Technologies',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 48),
          if (isMobile)
            _buildMobileSkills(context)
          else
            _buildDesktopSkills(context),
        ],
      ),
    );
  }

  Widget _buildDesktopSkills(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildSkillCategory(
            context,
            'Programming Languages',
            [
              _SkillItem(name: 'Dart', level: 0.9, color: const Color(0xFF00B4AB)),
              _SkillItem(name: 'JavaScript', level: 0.8, color: const Color(0xFFF7DF1E)),
              _SkillItem(name: 'Python', level: 0.7, color: const Color(0xFF3776AB)),
              _SkillItem(name: 'Java', level: 0.6, color: const Color(0xFFED8B00)),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildSkillCategory(
            context,
            'Frameworks & Tools',
            [
              _SkillItem(name: 'Flutter', level: 0.95, color: const Color(0xFF02569B)),
              _SkillItem(name: 'React Native', level: 0.7, color: const Color(0xFF61DAFB)),
              _SkillItem(name: 'Firebase', level: 0.8, color: const Color(0xFFFFCA28)),
              _SkillItem(name: 'Git', level: 0.85, color: const Color(0xFFF05032)),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildSkillCategory(
            context,
            'Design & UI/UX',
            [
              _SkillItem(name: 'Material Design', level: 0.9, color: const Color(0xFF6366F1)),
              _SkillItem(name: 'Figma', level: 0.7, color: const Color(0xFFF24E1E)),
              _SkillItem(name: 'Adobe XD', level: 0.6, color: const Color(0xFFFF61F6)),
              _SkillItem(name: 'Responsive Design', level: 0.85, color: const Color(0xFF10B981)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSkills(BuildContext context) {
    return Column(
      children: [
        _buildSkillCategory(
          context,
          'Programming Languages',
          [
            _SkillItem(name: 'Dart', level: 0.9, color: const Color(0xFF00B4AB)),
            _SkillItem(name: 'JavaScript', level: 0.8, color: const Color(0xFFF7DF1E)),
            _SkillItem(name: 'Python', level: 0.7, color: const Color(0xFF3776AB)),
            _SkillItem(name: 'Java', level: 0.6, color: const Color(0xFFED8B00)),
          ],
        ),
        const SizedBox(height: 48),
        _buildSkillCategory(
          context,
          'Frameworks & Tools',
          [
            _SkillItem(name: 'Flutter', level: 0.95, color: const Color(0xFF02569B)),
            _SkillItem(name: 'React Native', level: 0.7, color: const Color(0xFF61DAFB)),
            _SkillItem(name: 'Firebase', level: 0.8, color: const Color(0xFFFFCA28)),
            _SkillItem(name: 'Git', level: 0.85, color: const Color(0xFFF05032)),
          ],
        ),
        const SizedBox(height: 48),
        _buildSkillCategory(
          context,
          'Design & UI/UX',
          [
            _SkillItem(name: 'Material Design', level: 0.9, color: const Color(0xFF6366F1)),
            _SkillItem(name: 'Figma', level: 0.7, color: const Color(0xFFF24E1E)),
            _SkillItem(name: 'Adobe XD', level: 0.6, color: const Color(0xFFFF61F6)),
            _SkillItem(name: 'Responsive Design', level: 0.85, color: const Color(0xFF10B981)),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<_SkillItem> skills,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...skills.map((skill) => _buildSkillBar(context, skill)),
      ],
    );
  }

  Widget _buildSkillBar(BuildContext context, _SkillItem skill) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: skill.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.level,
              child: Container(
                decoration: BoxDecoration(
                  color: skill.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillItem {
  final String name;
  final double level;
  final Color color;

  _SkillItem({
    required this.name,
    required this.level,
    required this.color,
  });
} 