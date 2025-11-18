# Profile Image Placeholder

To add your profile image:

1. Add a profile image file named `profile.jpg` or `profile.png` to this directory
2. The recommended size is 400x400 pixels or larger (square format)
3. Update the CircleAvatar in `lib/screens/profile_screen.dart`:

```dart
CircleAvatar(
  radius: avatarRadius,
  backgroundImage: AssetImage('assets/images/profile.jpg'), // Uncomment this line
  // child: Icon(...), // Comment out or remove these lines
)
```

Currently, the app uses a default person icon as a placeholder.
