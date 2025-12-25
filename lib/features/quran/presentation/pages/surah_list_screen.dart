import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'surah_reader_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text("Al-Quran", style: AppTextStyles.headingMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppColors.textLight)),
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSurahList(),
                const Center(child: Text("Juzz View")),
                const Center(child: Text("Bookmarks View")),
                const Center(child: Text("Hadith View")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primaryGold,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textGrey,
        tabs: const [
          Tab(text: "Surah"),
          Tab(text: "Juzz"),
          Tab(text: "Bookmarks"),
          Tab(text: "Hadith"),
        ],
      ),
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahReaderScreen(
                  surahName: surah['name']!,
                  arabicName: surah['arabic']!,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundBeige,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryGold, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(surah['name']!, style: AppTextStyles.headingMedium.copyWith(fontSize: 16)),
                      Text("${surah['verses']} Verses • ${surah['translation']}", style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Text(
                  surah['arabic']!,
                  style: AppTextStyles.arabicText.copyWith(fontSize: 22, color: AppColors.primaryGold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final List<Map<String, String>> surahs = [
    {'name': 'Al-Fatihah', 'verses': '7', 'translation': 'The Opening', 'arabic': 'الفاتحة'},
    {'name': 'Al-Baqarah', 'verses': '286', 'translation': 'The Cow', 'arabic': 'البقرة'},
    {'name': 'Ali \'Imran', 'verses': '200', 'translation': 'Family of Imran', 'arabic': 'آل عمران'},
    {'name': 'An-Nisa', 'verses': '176', 'translation': 'The Women', 'arabic': 'النساء'},
    {'name': 'Al-Ma\'idah', 'verses': '120', 'translation': 'The Table', 'arabic': 'المائدة'},
  ];
}
