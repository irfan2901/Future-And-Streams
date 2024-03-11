import 'dart:async';

import 'package:flutter/material.dart';

class CounterWidgetTwo extends StatefulWidget {
  const CounterWidgetTwo({super.key});

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidgetTwo> {
  // Create a StreamController<int>
  final StreamController<int> _counterController = StreamController<int>();

  // Define a StreamSink<int> for adding data to the stream
  StreamSink<int> get counterSink => _counterController.sink;

  // Define a Stream<int> for listening to the data changes
  Stream<int> get counterStream => _counterController.stream;

  // Create a variable to hold the counter value
  int _counter = 0;

  // Subscription to listen to the counter stream
  late StreamSubscription<int> _subscription;

  @override
  void initState() {
    super.initState();

    // Use a StreamSubscription to listen to the stream
    _subscription = counterStream.listen((int data) {
      setState(() {
        _counter = data;
      });
    });
  }

  void _incrementCounter() {
    counterSink.add(_counter + 1);
  }

  void _decrementCounter() {
    if (_counter > 0) {
      counterSink.add(_counter - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamController with Subscription Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_counter'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Disposing of resources when the widget is no longer needed
    _subscription.cancel(); // Canceling the StreamSubscription
    _counterController.close(); // Closing the StreamController
    super.dispose();
  }
}
