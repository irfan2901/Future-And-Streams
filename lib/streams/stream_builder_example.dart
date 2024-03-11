import 'package:flutter/material.dart';

class StreamBuilderExample extends StatelessWidget {
  const StreamBuilderExample({super.key});

  Stream<int> counterStream() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder Example'),
      ),
      body: StreamBuilder<int>(
        stream: counterStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                child: Text('Counter: ${snapshot.data}'),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
