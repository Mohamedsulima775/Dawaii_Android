import 'package:flutter/material.dart';
import '../../../data/models/adherence_stats.dart';
import '../home/widgets/adherence_card.dart';
//import 'package:dawaii/presentation/screens/home/widgets/adherence_card.dart'; // تأكد من المسار

class AdherenceStatsScreen extends StatelessWidget {
  const AdherenceStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية (Mock Data) حتى تقوم بربط الـ Provider
    final stats = AdherenceStats(
      adherencePercentage: 94.0,
      totalDoses: 100,
      takenDoses: 94,
      skippedDoses: 2,
      missedDoses: 4,
      currentStreak: 5,
      longestStreak: 12,
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('إحصائيات الالتزام'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // استدعاء الكارت الذي صممته أنت (الملف رقم 1)
            AdherenceCard(
              percentage: stats.adherencePercentage,
              onTap: () {}, // نحن بالفعل في صفحة الإحصائيات
            ),

            const SizedBox(height: 24),

            const Text(
              'ملخص الجرعات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // عرض تفاصيل الـ Model في شبكة منظمة
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _buildStatItem('تم تناولها', stats.takenDoses.toString(), Colors.green),
                _buildStatItem('فائتة', stats.missedDoses.toString(), Colors.red),
                _buildStatItem('تم تخطيها', stats.skippedDoses.toString(), Colors.orange),
                _buildStatItem('أطول سلسلة', '${stats.longestStreak} يوم', Colors.blue),
              ],
            ),

            const SizedBox(height: 24),

            // مكان للرسوم البيانية المستقبلي (Chart Placeholder)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: const Column(
                children: [
                  Icon(Icons.bar_chart, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('الرسوم البيانية الأسبوعية ستظهر هنا',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}




/*
// لعرض احصائيات غامة
import 'package:flutter/material.dart';

class AdherenceStatsScreen extends StatelessWidget {
  const AdherenceStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adherence Stats')),
      body: const Center(child: Text('Charts & Stats Here')),
    );
  }
}

 */
