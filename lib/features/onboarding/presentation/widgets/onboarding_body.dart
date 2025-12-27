part of '../onboarding_screen.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Your Very Own",
      description:
          "Stay connected to your Deen with accurate prayer times, the Holy Quran, and more - right at your fingertips.",
      image: "assets/images/onboarding_1.png",
      highlightWord: "Spiritual Companion",
    ),
    OnboardingData(
      title: "Never Miss",
      description:
          "Get precise prayer times based on your location with customizable alerts for each Salah.",
      image: "assets/images/onboarding_2.png",
      highlightWord: "Your prayer",
    ),
    OnboardingData(
      title: "Read & Listen to The",
      description:
          "Access the full Quran with translations, tafsir, and audio recitations by renowned Qaris.",
      image: "assets/images/onboarding_3.png",
      highlightWord: "Holy Quran",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(_pages[index].image, fit: BoxFit.contain),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_pages[index].title, style: AppText.h2),
                              Text(
                                _pages[index].highlightWord,
                                style: AppText.h2,
                              ),
                              Text(
                                _pages[index].description,
                                style: AppText.b2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < _pages.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == i ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? AppColors.primary
                                : AppColors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    variant: _currentPage == _pages.length - 1
                        ? AppButtonVariant.filled
                        : AppButtonVariant.bordered,
                    borderRadius: _currentPage == _pages.length - 1 ? 16 : 60,
                    text: _currentPage == _pages.length - 1
                        ? "Get Started"
                        : "Continue",
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, '/main');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;
  final String highlightWord;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    required this.highlightWord,
  });
}
