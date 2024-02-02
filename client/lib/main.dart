import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  try {
    await pusher.init(
      apiKey: "2ce078c3959b1fa56af8",
      cluster: "ap2",
      onEvent: onEvent,
    );
    await pusher.subscribe(channelName: 'test-channel');
    await pusher.connect();
    final myChannel = await pusher.subscribe(channelName: "notification");
  } catch (e) {
    print("ERROR: $e");
  }

  runApp(const MyApp());
}

void onEvent(PusherEvent event) {
  // print("onEvent: $event");
  // print(event.data);

  // Show SnackBar notification when an event is received
  Map<String, dynamic> eventData = json.decode(event.data);
  print(eventData['message']);
  showSnackBar(
      eventData['message']); // Assuming 'message' is the key in your data
}

void showSnackBar(String message) {
  print(message);
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
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

int _counter = 0;

void _incrementCounter() {
  showSnackBar('Button pressed $_counter times.');
  _counter++;
}
