import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SurahReaderScreen extends StatelessWidget {
  final String surahName;
  final String arabicName;

  const SurahReaderScreen({
    super.key,
    required this.surahName,
    required this.arabicName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text(surahName, style: AppTextStyles.headingMedium),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_outline)),
        ],
      ),
      body: Column(
        children: [
          _buildSurahHeader(),
          const SizedBox(height: 20),
          Expanded(child: _buildAyahList()),
        ],
      ),
    );
  }

  Widget _buildSurahHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBlue,
        borderRadius: BorderRadius.circular(24),
        gradient: AppColors.prayerCardGradient,
      ),
      child: Column(
        children: [
          Text(arabicName, style: AppTextStyles.arabicText.copyWith(color: AppColors.accentGold, fontSize: 32)),
          const SizedBox(height: 8),
          Text(surahName, style: AppTextStyles.headingBold.copyWith(color: Colors.white, fontSize: 20)),
          const Divider(color: Colors.white24, height: 32),
          Text(
            "بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ",
            style: AppTextStyles.arabicText.copyWith(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildAyahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 10, // Mock count
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(color: AppColors.primaryGold, shape: BoxShape.circle),
                    child: Center(child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontSize: 12))),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.share_outlined, size: 20, color: AppColors.textLight),
                      SizedBox(width: 16),
                      Icon(Icons.play_circle_outline, size: 20, color: AppColors.textLight),
                      SizedBox(width: 16),
                      Icon(Icons.bookmark_outline, size: 20, color: AppColors.textLight),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ", // Mock ayah
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Amiri', // Assuming fonts are added
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "All praise is [due] to Allah, Lord of the worlds.", // Mock translation
                style: TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
            ],
          ),
        );
      },
    );
  }
}
