import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String worstSubject = "";
  String bestSubject = "";

  final List<Book> books = [
    Book(
      'Introduction to Algebra',
      Uri.parse(
        'https://www.amazon.com/Introduction-Algebra-John-Doe/dp/123456789',
      ),
      Subjects.Math,
    ),
    Book(
      'Geometry Fundamentals',
      Uri.parse(
        'https://www.amazon.com/Geometry-Fundamentals-Jane-Smith/dp/987654321',
      ),
      Subjects.Math,
    ),

    // Add more books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(books[index].title),
                  onTap: () {
                    launchUrl(books[index].amazonUrl);
                  },
                );
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
    fetchScores().then((value) {
      setState(() {
        scores = value;

        bestSubject = getBestSubject(scores);
        worstSubject = getWorstSubject(scores);
      });
    });

    super.initState();
  }
}
