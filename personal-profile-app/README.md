# Personal Profile App 

A beautiful, responsive Flutter application showcasing a developer's personal information with dark mode support and smooth animations.

## Features

- **Clean Modern UI**: Minimalist design with consistent spacing and rounded corners
- **Dark Mode Toggle**: Switch between light and dark themes seamlessly
- **Responsive Layout**: Adapts to mobile, tablet, and web screens
- **Reusable Widgets**: Custom `InfoTile` and `SkillChip` widgets following DRY principles
- **Smooth Animations**: Fade-in animation on profile section load
- **URL Launching**: Opens email, phone, GitHub, and LinkedIn links
- **Hot Reload Support**: Instant UI testing during development

## Screens

### Profile Header

- CircleAvatar with profile image
- Name and role display
- Short bio section

### Contact Information

- Email with `mailto:` link
- Phone with `tel:` link
- GitHub profile link
- LinkedIn profile link

### Skills Section

- Display skills using chips
- Icons for each technology
- Wrapped layout for responsive display

### Social Links

- Quick access to social media profiles
- Icon buttons with labels
- External URL launching

## Technologies Used

- **Flutter SDK**: 3.9.2+
- **Dart**: 3.9.2+
- **Packages**:
  - `url_launcher`: ^6.3.1 - For opening URLs
  - `google_fonts`: ^6.2.1 - For beautiful Poppins font
  - `cupertino_icons`: ^1.0.8 - For iOS-style icons

## Project Structure

```
lib/
├── main.dart                    # App entry point with theme management
├── screens/
│   └── profile_screen.dart     # Main profile screen with all sections
├── widgets/
│   ├── info_tile.dart          # Reusable contact info tile widget
│   └── skill_chip.dart         # Reusable skill chip widget
└── theme/
    └── app_theme.dart          # Centralized theme configuration

assets/
└── images/
    └── profile.jpg             # Profile image (add your own)
```

## Getting Started

### Prerequisites

- Flutter SDK installed (3.0.0 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- An emulator or physical device

### Installation

1. **Clone or download the project**
2. **Install dependencies**

   ```bash
   flutter pub get
   ```
3. **Add your profile image (optional)**

   - Add your profile image to `assets/images/profile.jpg`
   - Uncomment the `backgroundImage` line in `profile_screen.dart`:
     ```dart
     CircleAvatar(
       radius: avatarRadius,
       backgroundImage: AssetImage('assets/images/profile.jpg'),
     )
     ```
4. **Customize your information**

   - Open `lib/screens/profile_screen.dart`
   - Update the following:
     - Name (line ~80)
     - Role (line ~90)
     - Bio (line ~110)
     - Email (line ~140)
     - Phone (line ~146)
     - GitHub URL (line ~152)
     - LinkedIn URL (line ~159)
     - Skills list (line ~172)
     - Social links (line ~240)
5. **Run the app**

   ```bash
   flutter run
   ```
