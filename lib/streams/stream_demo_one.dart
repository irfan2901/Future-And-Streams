import 'dart:async';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  // Create a StreamController<int>
  final StreamController<int> _counterController = StreamController<int>();

  // Define a StreamSink<int> for adding data to the stream
  StreamSink<int> get counterSink => _counterController.sink;

  // Define a Stream<int> for listening to the data changes
  Stream<int> get counterStream => _counterController.stream;

  // Create a variable to hold the counter value
  int _counter = 0;

  // Implement initState to listen to the stream
  @override
  void initState() {
    super.initState();

    // Listen to the stream and update the UI
    counterStream.listen((int data) {
      setState(() {
        _counter = data;
      });
    });
  }

  // Implement methods to increment and decrement the counter
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
        title: const Text('StreamController Example'),
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

  // Dispose of the StreamController in the widget's dispose method
  @override
  void dispose() {
    _counterController.close();
    super.dispose();
  }
}
