
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _appVersion = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يمكن فتح الرابط')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن التطبيق'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 32),

            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.medical_services,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
            ),

            const SizedBox(height: 24),

            // App Name
            const Text(
              'دوائي',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // App Tagline
            Text(
              'نظام إدارة الأمراض المزمنة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 8),

            // Version
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'الإصدار $_appVersion ($_buildNumber)',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Description
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'عن التطبيق',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'تطبيق دوائي هو منصة متكاملة لإدارة مرضى الأمراض المزمنة، '
                        'يوفر تذكيرات ذكية للأدوية، متابعة الالتزام بالعلاج، '
                        'استشارات طبية فورية، وخدمة توصيل الأدوية.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Features
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'المميزات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeature(
                    Icons.medication_outlined,
                    'تذكيرات ذكية للأدوية',
                  ),
                  _buildFeature(
                    Icons.inventory_2_outlined,
                    'إدارة مخزون الأدوية',
                  ),
                  _buildFeature(
                    Icons.chat_bubble_outline,
                    'استشارات طبية فورية',
                  ),
                  _buildFeature(
                    Icons.shopping_bag_outlined,
                    'طلب وتوصيل الأدوية',
                  ),
                  _buildFeature(
                    Icons.insert_chart_outlined,
                    'تقارير الالتزام بالعلاج',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Contact & Support
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تواصل معنا',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactOption(
                    Icons.email_outlined,
                    'البريد الإلكتروني',
                    'support@dawaii.com',
                        () => _launchURL('mailto:support@dawaii.com'),
                  ),
                  const Divider(height: 24),
                  _buildContactOption(
                    Icons.language,
                    'الموقع الإلكتروني',
                    'www.dawaii.com',
                        () => _launchURL('https://www.dawaii.com'),
                  ),
                  const Divider(height: 24),
                  _buildContactOption(
                    Icons.code,
                    'GitHub',
                    'Mohamedsulima775/My_medicinal',
                        () => _launchURL(
                        'https://github.com/Mohamedsulima775/My_medicinal'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Legal
            _buildCard(
              child: Column(
                children: [
                  _buildLegalOption(
                    'سياسة الخصوصية',
                        () {
                      // TODO: Show privacy policy
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('قريباً: سياسة الخصوصية'),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _buildLegalOption(
                    'شروط الاستخدام',
                        () {
                      // TODO: Show terms of service
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('قريباً: شروط الاستخدام'),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _buildLegalOption(
                    'التراخيص',
                        () {
                      showLicensePage(
                        context: context,
                        applicationName: 'دوائي',
                        applicationVersion: '$_appVersion ($_buildNumber)',
                        applicationIcon: Icon(
                          Icons.medical_services,
                          size: 48,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Credits
            Text(
              '© 2025 دوائي. جميع الحقوق محفوظة.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'صُنع بـ ❤️ في اليمن ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(
      IconData icon,
      String title,
      String value,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildLegalOption(String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}



