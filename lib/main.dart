import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizer_app/providers/goals.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/screens/wallpaper_screen.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//screens

import 'package:organizer_app/screens/home_screen.dart';
import 'package:organizer_app/screens/routines_screen.dart';

import 'package:organizer_app/screens/goals_screen.dart';
import 'package:organizer_app/screens/help_screen.dart';

//porviders
import './providers/tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Tasks()),
          ChangeNotifierProvider(create: (context) => Routines()),
          ChangeNotifierProvider(create: (context) => Goals()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              //TODO: Implement a theme
              // accentColor: Color(0xFFD6CCC6),
              primaryColor: const Color(
                  0xFFADB7D2), //Color(0xFFF5EBE0), // Color(0xFFF7F5EB),
              // splashColor: const Color(0xFFD6CCC6),
              // scaffoldBackgroundColor: const Color(0xFFEAE0DA),
              appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'TiltNeon',
                      color: Color(0xFFeceef4)),
                  backgroundColor: Color(0xFF0C0F17),
                  foregroundColor: Color(0xFFADB7D2),
                  shadowColor: Color(0x00FFFFFF),
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color.fromRGBO(0, 0, 0, 0))),
              fontFamily: 'Rubik',
              // elevatedButtonTheme: const ElevatedButtonThemeData(
              //     style: ButtonStyle(
              //   foregroundColor:
              //       MaterialStatePropertyAll<Color>(Color(0xFFEAE0DA)),
              //   textStyle: MaterialStatePropertyAll<TextStyle>(
              //       TextStyle(fontSize: 18)),
              //   backgroundColor:
              //       MaterialStatePropertyAll<Color>(Color(0xFF5C5470)),
              // )),
              // textButtonTheme: const TextButtonThemeData(
              //     style: ButtonStyle(
              //         foregroundColor:
              //             MaterialStatePropertyAll<Color>(Color(0xFF5C5470)),
              //         textStyle: MaterialStatePropertyAll<TextStyle>(
              //             TextStyle(fontSize: 18)),
              //         overlayColor:
              //             MaterialStatePropertyAll<Color>(Color(0x4D5C5470)))),
              textTheme: const TextTheme(
                  displayLarge: TextStyle(
                    fontSize: 72.0,
                    fontFamily: 'TiltNeon',
                    //color: Colors.white,
                  ),
                  titleLarge: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'TiltNeon',
                    //color: Color(0xFF5C5470),
                  ),
                  titleMedium: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600,
                    //color: Color(0xFF141721),
                  ),
                  titleSmall: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Rubik',
                    //color: Color(0xFF5C5470),
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 16.0,
                    //color: Color(0xFF5C5470),
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    // color: Color(0xFF5C5470),
                  )),

              // colorScheme: ColorScheme.fromSwatch(
              //   primarySwatch: ColorsC,
              //   primaryColorDark: Color(0xFF0C0F17),
              //   accentColor: Color(0xFF0C0F17),
              //   backgroundColor: Color(0xFF0C0F17),
              //   cardColor: Colors.blue,
              //   errorColor: Colors.blue,
              //   secondaryHeaderColor: Colors.blue,
              //   dialogBackgroundColor: Colors.blue,
              //   focusColor: Colors.blue,
              //   highlightColor: Colors.blue,
              //   hoverColor: Colors.blue,
              //   indicatorColor: Colors.blue,
              //   splashColor: Colors.blue,
              //   selectedRowColor: Colors.blue,
              //   toggleableActiveColor: Colors.blue,
              //   unselectedWidgetColor: Colors.blue,
              //   shadowColor: Colors.blue,
              //   brightness: Brightness.dark,
              // ),
              colorScheme: const ColorScheme(
                primary: Color(0xFFadb7d2),
                //primaryVariant: Color(0xFFadb7d2),
                secondary: Color(0xFF666038),
                //secondaryVariant: Color(0xFF666038),
                surface: Color(0xFF1a2133),
                background: Color(0xFF0C0F17),
                error: Color(0xFF672A2A),
                onPrimary: Color(0xFF1a2133),
                onSecondary: Color(0xFFECEEF4),
                onSurface: Color(0xFFECEEF4),
                onBackground: Color(0xFFECEEF4),
                onError: Color(0xFFECEEF4),
                brightness: Brightness.dark,
              )),

          //home: const HomeScreen(),

          routes: {
            '/': (context) => const HomeScreen(),
            HelpScreen.pageRoute: (context) => const HelpScreen(),
            GoalsScreen.pageRoute: (context) => const GoalsScreen(),
            RoutinesScreen.pageRoute: (context) => const RoutinesScreen(),
            WallpaperScreen.pageRoute: (context) => const WallpaperScreen(),
          },
        ));
  }
}
