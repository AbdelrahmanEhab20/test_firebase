import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_firebase/green_page.dart';
import 'package:test_firebase/red_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(MyApp());
}

// void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(title: 'Testing Firebase Flutter'),
      routes: {"red": (_) => RedPage(), "green": (_) => GreenPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //@@@@@@@@@@@@@  instance.getInitialMessage @@@@@@@@@@
    //If the application has been opened from a terminated state via a [RemoteMessage] (containing a [Notification]),
    //it will be returned, otherwise it will be null.
    FirebaseMessaging.instance.getInitialMessage();

    //@@@@@@@@@@@@@  FirebaseMessaging.onMessage @@@@@@@@@@
    //Returns a Stream that is called when an incoming FCM payload is received whilst the Flutter instance is in the foreground.
    FirebaseMessaging.onMessage.listen((message) {
      ///===================================================================
      ///===================================================================
      // foreground only this will work
      if (message.notification != null) {
        print("##########");
        print("message.notification.title");
        print(message.notification!.title);
        print("##########");
        print("message.notification.body");
        print(message.notification!.body);
      }
    });
    //@@@@@@@@@@@@@  FirebaseMessaging.onMessageOpenedApp @@@@@@@@@@
    //Returns a [Stream] that is called when a user presses a notification message displayed via FCM.
    // A Stream event will be sent if the app has opened from a background state (not terminated).

    //when the app in background and opened user will tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      print(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Container(
            child: Center(
              child: Text(
                "You will receive a new message soon",
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ));
  }
}
