import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iLearn/pages/analytics_page.dart';
import 'package:iLearn/utils/enums.dart';
import 'package:iLearn/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class Book {
  final String title;
  final Uri amazonUrl;
  final Subjects subject;

  Book(this.title, this.amazonUrl, this.subject);
}

class RecommedationPage extends StatefulWidget {
  const RecommedationPage({Key? key}) : super(key: key);

  @override
  State<RecommedationPage> createState() => _RecommendationPage();
}

class _RecommendationPage extends State<RecommedationPage> {
  List scores = [];
  Subjects? worstSubject;
  Subjects? bestSubject;

  final List<Book> books = [
    Book(
      'Algebra Essentials',
      Uri.parse(
        'https://www.amazon.com/Algebra-Essentials-Practice-Workbook-Answers/dp/1453661387/',
      ),
      Subjects.Math,
    ),
    Book(
      'Essential Prealgebra Skills',
      Uri.parse(
        'https://www.amazon.com/Essential-Prealgebra-Skills-Practice-Workbook/dp/1941691080/',
      ),
      Subjects.Math,
    ),

    Book(
      'Order of Operations',
      Uri.parse(
        'https://www.amazon.com/Order-Operations-Pre-Algebra-Step-Step/dp/1635785456/',
      ),
      Subjects.Math,
    ),

    // English
    Book(
      'English for Everyone',
      Uri.parse(
        'https://www.amazon.com/English-Everyone-Slipcase-Beginner-DK/dp/1465475583/',
      ),
      Subjects.English,
    ),

    Book(
      'English Short Stories for Beginners',
      Uri.parse(
        'https://www.amazon.com/English-Stories-Beginners-Intermediate-Learners/dp/1950321282/',
      ),
      Subjects.English,
    ),

    Book(
      'The Art of English Grammar',
      Uri.parse(
        'https://www.amazon.com/Art-English-Grammar-Practice-Workbook/dp/1941691366/',
      ),
      Subjects.English,
    ),

    // History
    Book(
      'Epic Stories For Kids and Family',
      Uri.parse(
        'https://www.amazon.com/Epic-Stories-Kids-Family-Fascinating/dp/1957515163/',
      ),
      Subjects.History,
    ),

    Book(
      'Spectacular Stories for Curious Kids',
      Uri.parse(
        'https://www.amazon.com/Spectacular-Stories-Curious-Kids-Fascinating/dp/1953429130/',
      ),
      Subjects.History,
    ),

    Book(
      'Knowledge Encyclopedia: Space',
      Uri.parse(
        'https://www.amazon.com/Knowledge-Encyclopedia-Wonder-House-Books/dp/935440443X/',
      ),
      Subjects.History,
    ),

    // General
    Book(
      'Awesome Trivia For Kids',
      Uri.parse(
        'https://www.amazon.com/Awesome-Trivia-Kids-Challenging-Questions/dp/B08BDZ2HB5/',
      ),
      Subjects.General,
    ),

    Book(
      'HISTORY Channel',
      Uri.parse(
        'https://www.amazon.com/HISTORY-Channel-Trivia-Game-Knowledge/dp/B0BZQTMVRM/',
      ),
      Subjects.General,
    ),

    Book(
      'Super Interesting Facts',
      Uri.parse(
        'https://www.amazon.com/Super-Interesting-Facts-Smart-Kids/dp/B0BGGM9SGY/',
      ),
      Subjects.General,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recommended Books'),
          leading: const Icon(Icons.book),
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: ListTile(
                          title: Text(
                            books[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Text("${index + 1}"),
                          onTap: () {
                            launchUrl(books[index].amazonUrl);
                          },
                        ));
                  })),
        ]));
  }

  fetchScores() async {
    List fetchedScores = [];

    final collection = FirebaseFirestore.instance.collection("scores");
    await collection.get().then((value) {
      for (var element in value.docs) {
        final data = element.data();

        // if data is not from current user
        if (data["user"] != FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }

        var score = {
          "subject": data["subject"],
          "score": data["score"],
          "timestamp": data["timestamp"],
          "chartData": ChartData(data["timestamp"].toDate().day, data["score"]),
        };

        fetchedScores.add(score);
      }
    });

    return fetchedScores;
  }

  @override
  initState() {
    try {
      EasyLoading.show(
        status: 'Getting Recommendations',
        maskType: EasyLoadingMaskType.black,
      );

      fetchScores().then((value) {
        setState(() {
          scores = value;

          bestSubject = getSubject(getBestSubject(scores));
          worstSubject = getSubject(getWorstSubject(scores));

          // Sort books array based on worst subject first and best subject last

          if (bestSubject == null || worstSubject == null) return;

          books.sort((a, b) {
            if (a.subject == worstSubject) {
              return -1;
            } else if (b.subject == worstSubject) {
              return 1;
            } else if (a.subject == bestSubject) {
              return 1;
            } else if (b.subject == bestSubject) {
              return -1;
            } else {
              return 0;
            }
          });
        });
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
      super.initState();
    }
  }
}
