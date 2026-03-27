import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/services/preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    
    await Future.delayed(const Duration(seconds: 2));
    
    final prefs = PreferencesService();
    final hasInterests = await prefs.hasSavedInterests();

    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => hasInterests ? const MainScreen() : const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000666),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.public, size: 80, color: Colors.white),
            const SizedBox(height: 24),
            Text(
              'Editorial\nIntelligence',
              textAlign: TextAlign.center,
              style: GoogleFonts.newsreader(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
