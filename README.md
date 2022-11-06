# Quizly App

A simple Quiz App that contains a group of curated questions and their answers and checks for the correctness of the solution given by the user.

## Getting Started

This project is a starting point for our Flutter application.

### Useful flutter commands

```bash
# Analyzes the project’s Dart source code
flutter analyze
```

```bash
# Formats Flutter source code
Flutter format
```

```bash
# Run tests
flutter test
```

```bash
# Works with packages
flutter pub 
```

To find out more check [online documentation](https://docs.flutter.dev/).

### File structure

```bash
├── android         # Android files
├── assets          # Directory containing assets such as images, audio
│    ├── audio      # Audio assets
│    └── images     # Images assets
├── build           # App build
├── ios             # iOS files
├── lib
│    ├── widgets    # Custom widgets
│    ├── pages      # App pages
│    ├── services   # Contains files responsible for working to external APIs, database, etc. 
│    └── main.dart  # Main file of the app containing routes for pages - ADD ONLY ROUTES !!!
├── test            # Unit tests for the project
│    ├── widgets    # Contains files responsible for testing custom widgets  
│    ├── pages      # Contains files responsible for testing app pages 
│    └── services   # Contains files responsible for testing services 
```

## Tests

File naming convention:
- begin with name of file to test
- end with _test

For instance, testing `home.dart` in file `home_test.dart`
