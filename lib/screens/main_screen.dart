import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/screens/feed_screen.dart';
import 'package:news_app/screens/saved_screen.dart';
import 'package:news_app/providers/navigation_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();

    final List<Widget> screens = [
      const FeedScreen(),
      const SavedScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => context.read<NavigationProvider>().setIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF000666),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), activeIcon: Icon(Icons.bookmark), label: 'SAVED'),
        ],
      ),
    );
  }
}
