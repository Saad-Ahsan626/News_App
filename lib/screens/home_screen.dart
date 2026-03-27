import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/widgets/category_screen.dart';
import 'package:news_app/services/preferences_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set _selectedInterests = {'Tech'};

  final List<Map<String, dynamic>> _featuredInterests = [
    {
      'name': 'Tech',
      'icon': Icons.memory,
      'imageUrl': 'assets/images/tech.jpg',
    },
    {
      'name': 'Politics',
      'icon': Icons.account_balance,
      'imageUrl': 'assets/images/politics.jpg',
    },
    {
      'name': 'Science',
      'icon': Icons.science,
      'imageUrl': 'assets/images/science.jpg',
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_basketball,
      'imageUrl': 'assets/images/sports.jpg',
    },
  ];

  final List<Map<String, dynamic>> _otherInterests = [
    {'name': 'Arts', 'icon': Icons.palette},
    {'name': 'Finance', 'icon': Icons.payments},
    {'name': 'Travel', 'icon': Icons.explore},
    {'name': 'Health', 'icon': Icons.favorite},
    {'name': 'Environment', 'icon': Icons.public},
    {'name': 'Entertainment', 'icon': Icons.movie},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF000666);
    final secondaryTextColor = isDark ? Colors.grey[400] : Colors.grey[700];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_selectedInterests.length} / 10',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Personalize\nYour Feed',
                style: GoogleFonts.newsreader(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select your interests and stay updated on what matters to you.',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  color: secondaryTextColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: _featuredInterests.length,
                itemBuilder: (context, index) {
                  final interest = _featuredInterests[index];
                  final isSelected = _selectedInterests.contains(
                    interest['name'],
                  );

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedInterests.remove(interest['name']);
                        } else {
                          _selectedInterests.add(interest['name']);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: interest['imageUrl'] != null
                            ? Theme.of(context).cardColor
                            : (isDark ? const Color(0xFF1A2251) : const Color(0xFFF2F3FF)),
                        image: interest['imageUrl'] != null
                            ? DecorationImage(
                                image: AssetImage(interest['imageUrl']),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withAlpha((0.5 * 255).toInt()),
                                  BlendMode.darken,
                                ),
                              )
                            : null,
                        border: isSelected && interest['imageUrl'] == null
                            ? Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  interest['icon'],
                                  color: interest['imageUrl'] != null
                                      ? Colors.white
                                      : Colors.blueAccent,
                                  size: 32,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  interest['name'].toUpperCase(),
                                  style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                    color: interest['imageUrl'] != null
                                      ? Colors.white
                                      : textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
              Text(
                'MORE INTERESTS',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _otherInterests.map((interest) {
                  final isSelected = _selectedInterests.contains(
                    interest['name'],
                  );
                  return CategoryScreen(
                    label: interest['name'],
                    icon: interest['icon'],
                    isSelected: isSelected,
                    onSelected: () {
                      setState(() {
                        if (isSelected) {
                          _selectedInterests.remove(interest['name']);
                        } else {
                          _selectedInterests.add(interest['name']);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedInterests.isEmpty) return;
                    await PreferencesService().saveInterests(_selectedInterests.cast<String>().toList());
                    if (!context.mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'CONTINUE',
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
