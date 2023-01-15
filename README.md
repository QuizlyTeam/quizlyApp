# Quizly App

A simple Quiz App that contains a group of curated questions and their answers and checks for the correctness of the solution given by the user.
Additional features:
* adding own quizzes
* conquering in quizzes against other players at the same time (mupltiplayer mode)
* adding own quizzes, editing them and deleting,
* statistics for very logged users,
* saved progress for logged users,
* multiple ways to log in to the app


## Getting Started

This project is a starting point for our Flutter application.

### Install instruction
Make sure you have installed emulator before launching app!
```bash
#clone repository
git clone https://github.com/QuizlyTeam/quizly_app.git

#get packages
flutter pub get
#run application
flutter run


````

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



### File structure

```bash

├── android                    # Android files
├── assets                     # Directory containing assets such as images, audio
│    ├── audio                 # Audio assets
│    └── images                # Images assets
├── build                      # App build
├── docs                       # App documentation
├── ios                        # iOS files
├── lib                        # Main file
│    ├── api_functions         # Functions for API
│    ├── auth                  # Authorization service
│    ├── classes               # Simple clasess
│    ├── widgets               # Custom widgets
│    ├── pages                 # App pages
│    ├── services              # Contains files responsible for working to external APIs, database, etc. 
│    ├── firebase_options.dart #firebase file
│    └── main.dart             # Main file of the app containing routes for pages - ADD ONLY ROUTES !!!
├── test                       # Unit tests for the project
│    ├── widgets               # Contains files responsible for testing custom widgets  
│    ├── pages                 # Contains files responsible for testing app pages 
│    └── services              # Contains files responsible for testing services 
```
## License
[![Licence](https://img.shields.io/github/license/QuizlyTeam/quizly_app?style=for-the-badge)](./LICENSE)


