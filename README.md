# Portfolio Website

A modern, responsive portfolio website built with Flutter for web, inspired by https://www.amrmustafa.dev/.

## Features

- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Single Page Application**: Smooth scrolling between sections
- **Modern UI/UX**: Clean, professional design with dark theme
- **Multiple Sections**:
  - Hero section with compelling introduction
  - About section with personal information and experience
  - Skills section showcasing technical expertise
  - Projects section featuring portfolio work
  - Contact section with contact form and social links

## Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Google Fonts**: Typography
- **URL Launcher**: External link handling

## Getting Started

### Prerequisites

- Flutter SDK (3.6.1 or higher)
- Dart SDK
- Web browser

## Responsive Layout

- Breakpoints (defined in `lib/constants/dimensions.dart`):
  - Mobile: width < 768
  - Tablet: 768 ≤ width < 1024
  - Desktop: width ≥ 1024
- Tools used: `MediaQuery`, `LayoutBuilder`, `Expanded`/`Flexible`, `Wrap`, `FittedBox`, and safe paddings from `AppDimensions`.
- Navigation:
  - Mobile: top bar with hamburger button opening a bottom sheet menu
  - Tablet: top bar; sections adapt spacing and sizing
  - Desktop: top bar with inline items
- Sections:
  - Content stacks vertically on mobile; multi-column only on larger screens
  - Images and carousels scale using constraints and `FittedBox`
  - Tap targets meet ≥44x44 and paddings scale with screen size
