import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:news_app/providers/article_provider.dart';
import 'package:news_app/providers/navigation_provider.dart';
import 'package:news_app/providers/saved_article_provider.dart';
import 'package:news_app/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SavedArticleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, 
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: const Color(0xFFFAF8FF),
              primaryColor: const Color(0xFF000666),
              cardColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Color(0xFF000666)),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFF000666),
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF0A1237),
              primaryColor: const Color(0xFF0A1237),
              cardColor: const Color(0xFF111942),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: const Color(0xFF111942),
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey[600],
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
