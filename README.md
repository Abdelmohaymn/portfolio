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

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd portfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d web-server --web-port 8080
```

4. Open your browser and navigate to `http://localhost:8080`

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── portfolio_app.dart        # Main app configuration and theming
├── sections/
│   └── home.dart            # Main home section containing all sections
└── widgets/
    ├── navigation_bar.dart   # Navigation bar component
    ├── hero_section.dart     # Hero/introduction section
    ├── about_section.dart    # About and experience section
    ├── skills_section.dart   # Skills and technologies section
    ├── projects_section.dart # Portfolio projects section
    └── contact_section.dart  # Contact information and form
```

## Customization

### Personal Information
Update the following files to customize the portfolio for your needs:
- `lib/widgets/hero_section.dart`: Change name, title, and description
- `lib/widgets/about_section.dart`: Update personal information and experience
- `lib/widgets/skills_section.dart`: Modify skills and proficiency levels
- `lib/widgets/projects_section.dart`: Add your own projects
- `lib/widgets/contact_section.dart`: Update contact details and social links

### Styling
- Colors and theme: Modify `lib/portfolio_app.dart`
- Typography: Update Google Fonts in the theme
- Layout: Adjust responsive breakpoints in individual widget files

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

## Deployment

To build for production:
```bash
flutter build web
```

The built files will be in the `build/web/` directory, ready for deployment to any web hosting service.

## License

This project is open source and available under the [MIT License](LICENSE).
