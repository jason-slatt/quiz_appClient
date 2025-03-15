// ignore_for_file: avoid_print

import 'package:hq_arena/utils/audManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:hq_arena/constant/global_variables.dart';
import 'package:hq_arena/features/main/welcome.dart';
import 'package:hq_arena/providers/user_provider.dart';
import 'package:hq_arena/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/auth/screens/auth_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is ready before initialization

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Ensures Firebase is configured properly
  );

  configLoading(); // Call this after Firebase is initialized (if needed)

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BackgroundMusic.play();
    setupFCM();
    super.initState();
  }

  void setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request Notification Permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification Permission Granted!");
    }

    // Get FCM Token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // 📌 Foreground (App Open) Notification Handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification: ${message.notification?.title}");
    });

    // 📌 When App is Opened by Clicking a Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "User Opened App from Notification: ${message.notification?.title}");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IQ ARENA',
        darkTheme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariable.backgroundColor,
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the coloTrScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: const ColorScheme.light(
            primary: GlobalVariable.secondaryColor,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: (setting) => generateRoute(setting),
        home: const AuthWrapper());
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = '';
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userProvider = Provider.of<UserProvider>(context, listen: false);

        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            userProvider.setUser(
              user.displayName ?? "Guest",
              user.email ?? "",
              userId = user.uid,
              user.photoURL ?? "",
            );
          }
          return Welcome(
            userId: userId,
          ); // Redirect to main page
        }

        return const AuthScreen(); // Redirect to login/signup if not signed in
      },
    );
  }
}
