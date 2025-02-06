import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/main/home.dart';
import 'package:HGArena/features/main/welcome.dart';
import 'package:HGArena/providers/user_provider.dart';
import 'package:HGArena/router.dart';

import 'features/auth/screens/auth_screen.dart';

void main() async {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create:(context) => UserProvider()
        )
      ],
      child: const MyApp()));
  configLoading();
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp();
  }
  Future<void> initializeApp() async {
   // await authService.getUserData(context);

    // Additional initialization logic if needed
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

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
          colorScheme: const ColorScheme.light(primary: GlobalVariable.secondaryColor, ),
          useMaterial3: true,
        ),
        onGenerateRoute: (setting) => generateRoute(setting),
        home: const Welcome()
    );
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
    ..maskColor = Colors.blue.withOpacity(100)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}
