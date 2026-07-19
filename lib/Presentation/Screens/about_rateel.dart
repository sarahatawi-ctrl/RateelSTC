import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/feature_item.dart';

class AboutRateel extends StatelessWidget {
  const AboutRateel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('اعرف أكثر عن رتيل'),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  '/Users/sarahatawi/STC/stc/assets/images/RateelLogo.png',
                  height: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 100),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'تطبيق رتيل من stc',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'تطبيق "رتيل" (Rateel) من شركة stc السعودية هو تطبيق رقمي متكامل يهدف إلى مساعدة المستخدمين على تنظيم عباداتهم، وخاصة قراءة وحفظ القرآن الكريم، والاستمرار فيها بشكل يومي.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 16),

              const Text(
                'من أبرز مميزات التطبيق:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // استدعاء الودجت
              buildFeatureItem('أوقات الصلاة الدقيقة مع التنبيهات.', theme),
              buildFeatureItem(
                'مصحف إلكتروني كامل قابل للقراءة والاستماع لأكثر من 650 قارئًا.',
                theme,
              ),
              buildFeatureItem(
                'خاصية الختمة لمتابعة قراءة القرآن وتذكيرك بها.',
                theme,
              ),
              buildFeatureItem('مكتبة متكاملة من الأذكار والأدعية.', theme),

              const SizedBox(height: 24),

              const Text(
                'يهدف تطبيق رتيل إلى أن يكون رفيقك اليومي في رحلتك الروحية، مقدمًا لك كل ما تحتاجه في مكان واحد وبواجهة سهلة الاستخدام.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 32),

              const Divider(color: Colors.white24, thickness: 1),

              const SizedBox(height: 16),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Share.share('حمل تطبيق الأذكار الرائع من هنا!'),
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text(
                    'مشاركة التطبيق',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
