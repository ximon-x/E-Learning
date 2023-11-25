# i-Learn

## Description

i-Learn is a user-friendly application that allows users to track and manage their learning progress by the use of self-assessment quizzes. The application is designed to be used by students and teachers alike. Teachers can create quizzes and assign them to students. Students can take quizzes and view their results.

## Table of Contents

- [i-Learn](#i-learn)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Useful Links](#useful-links)

## Installation

To build the binaries for this project, you will need to install the following dependencies:

1. [Flutter](https://flutter.dev/docs/get-started/install)
2. [Android Studio](https://developer.android.com/studio)
3. [Xcode](https://developer.apple.com/xcode/)
4. [Visual Studio Code](https://code.visualstudio.com/)
5. [Dart](https://dart.dev/get-dart)
6. [Git](https://git-scm.com/downloads)
7. [Python](https://www.python.org/downloads/)
8. [Flask](https://flask.palletsprojects.com/en/1.1.x/installation/)

You can then compile the Android and ios binaries by running the following commands:

```bash
flutter build apk --release
```

The server can be started by running the following command:

```bash
poetry shell
python server/main.py
```

The server is already live and hosted on PythonAnywhere.

## Usage

Using the application is simple. The user can either sign up using their email address and password or sign in using the Google Account. This makes the app accessibility great for everyone as they can use their existing Google Account to sign in. Once the user is signed in, they can view their dashboard. The dashboard shows the user's progress in the form of a scatterplot chart.

Navigating to the Quizzes tab, the application renders a self-paced quiz with no time limit for the user to attempt, the application currently has questions on just Math, English, History and General Topics but it can easily be updated to include more subjects. The user can also view their results for the quizzes they have attempted. The user's score is then sent to the application Firestore DB so the user can perform an analysis on his progress.

Moving forward, the analytics tab is where the user can view their current statistics on their best and worst subjects and also the hour of the day where he achieved peak performance. The user can also view the total number of quizzes they have attempted for each subject in the form of a bar chart and lastly see the real-time chart of their monthly activity.

## Useful Links

To get more information on the project, please visit the following links:

1. [Flutter Documentation](https://flutter.dev/docs)
2. [Firebase Documentation](https://firebase.google.com/docs)
3. [Flask Documentation](https://flask.palletsprojects.com/en/1.1.x/)
4. [PythonAnywhere](https://www.pythonanywhere.com/)
5. [Dart Documentation](https://dart.dev/guides)
6. [Git Documentation](https://git-scm.com/doc)
7. [NumPy Documentation](https://numpy.org/doc/)
