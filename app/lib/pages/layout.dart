import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // ignore: unused_field
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title:
              Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          leading: IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          )),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Google'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Facebook'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
