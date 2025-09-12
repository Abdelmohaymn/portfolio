import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';

class CustomNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(String) onSelected;
  final String currentSection;

  const CustomNavigationBar({
    super.key,
    required this.onSelected,
    required this.currentSection,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<_NavItem> _items = [
    _NavItem(label: AppStrings.homeNav, id: 'home'),
    _NavItem(label: AppStrings.aboutNav, id: 'about'),
    _NavItem(label: AppStrings.experienceTitle, id: 'experience'),
    _NavItem(label: AppStrings.projectsNav, id: 'projects'),
    _NavItem(label: AppStrings.achievementsTitle, id: 'achievements'),
    _NavItem(label: AppStrings.contactNav, id: 'contact'),
  ];

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackgroundAlt,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ..._items.map((item) {
                final isSelected = widget.currentSection == item.id;
                return ListTile(
                  dense: true,
                  title: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    widget.onSelected(item.id);
                  },
                );
              }).toList(),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool useCompactMenu = size.width < AppDimensions.tabletBreakpoint;

    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: useCompactMenu ? AppDimensions.spacingL : AppDimensions.sectionPaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.cardBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => widget.onSelected('home'),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: const Text(
                'Abdelmohaymn',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          ...useCompactMenu
              ? [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => _openMobileMenu(context),
                  ),
                ]
              : _items.map((item) => _buildNavItem(item, false)).toList(),
        ],
      ),
    );
  }

  Widget _buildNavItem(_NavItem item, bool isMobile) {
    final isSelected = widget.currentSection == item.id;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? AppDimensions.spacingXS : AppDimensions.spacingM),
      child: TextButton(
        onPressed: () => widget.onSelected(item.id),
        child: Text(
          item.label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String id;

  const _NavItem({required this.label, required this.id});
}