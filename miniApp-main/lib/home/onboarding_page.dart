
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2); 
          },
          children: [
            _buildPage(color: Colors.blue, title: "Планируйте дела"),
            _buildPage(color: Colors.green, title: "Достигайте целей"),
            _buildPage(color: Colors.orange, title: "Будьте продуктивны"),
          ],
        ),
      ),
      bottomSheet: isLastPage 
        ? TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(80),
              backgroundColor: Colors.blue,
            ),
            child: const Text("Начать", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_done', true);

              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Mini App',)),
                );
              }
            },
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _controller.jumpToPage(2), 
                  child: const Text("Пропустить"),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPage({required Color color, required String title}) {
    return Container(
      color: color,
      child: Center(
        child: Text(title, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}