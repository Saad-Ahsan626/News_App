import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/feed_screen.dart';
import 'package:news_app/widgets/category_screen.dart';

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
      'imageUrl':
          'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800',
    },
    {
      'name': 'Politics',
      'icon': Icons.account_balance,
      'imageUrl':
          'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=800',
    },
    {
      'name': 'Science',
      'icon': Icons.science,
      'imageUrl':
          'https://images.unsplash.com/photo-1507413245164-6160d8298b31?auto=format&fit=crop&q=80&w=800',
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_basketball,
      'imageUrl':
          'https://images.unsplash.com/photo-1504450758481-7338eba7524a?auto=format&fit=crop&q=80&w=800',
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
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
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
                    color: const Color(0xFF000666),
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
                  color: const Color(0xFF000666),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select your interests and stay updated on what matters to you.',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  color: Colors.grey[700],
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
                            ? Colors.grey[200]
                            : const Color(0xFFF2F3FF),
                        image: interest['imageUrl'] != null
                            ? DecorationImage(
                                image: NetworkImage(interest['imageUrl']),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken,
                                ),
                              )
                            : null,
                        border: isSelected && interest['imageUrl'] == null
                            ? Border.all(
                                color: const Color(0xFF000666),
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
                                      : const Color(0xFF000666),
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
                                        : const Color(0xFF000666),
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
                  color: const Color(0xFF000666).withOpacity(0.6),
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
                        if (isSelected)
                          _selectedInterests.remove(interest['name']);
                        else
                          _selectedInterests.add(interest['name']);
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
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF000666),
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
