
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dawaii/services/settings_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _medicationReminders = true;
  bool _stockAlerts = true;
  bool _consultationUpdates = true;
  bool _orderUpdates = true;
  bool _generalNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _medicationReminders =
          prefs.getBool('notif_medication_reminders') ?? true;
      _stockAlerts = prefs.getBool('notif_stock_alerts') ?? true;
      _consultationUpdates =
          prefs.getBool('notif_consultation_updates') ?? true;
      _orderUpdates = prefs.getBool('notif_order_updates') ?? true;
      _generalNotifications =
          prefs.getBool('notif_general_notifications') ?? true;
      _soundEnabled = prefs.getBool('notif_sound') ?? true;
      _vibrationEnabled = prefs.getBool('notif_vibration') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('notif_medication_reminders', _medicationReminders);
    await prefs.setBool('notif_stock_alerts', _stockAlerts);
    await prefs.setBool('notif_consultation_updates', _consultationUpdates);
    await prefs.setBool('notif_order_updates', _orderUpdates);
    await prefs.setBool('notif_general_notifications', _generalNotifications);
    await prefs.setBool('notif_sound', _soundEnabled);
    await prefs.setBool('notif_vibration', _vibrationEnabled);

    // Update FCM settings if needed
    await _updateFCMSettings();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ الإعدادات'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _updateFCMSettings() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        // Subscribe/unsubscribe from topics based on settings
        if (_medicationReminders) {
          await FirebaseMessaging.instance
              .subscribeToTopic('medication_reminders');
        } else {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic('medication_reminders');
        }

        if (_stockAlerts) {
          await FirebaseMessaging.instance.subscribeToTopic('stock_alerts');
        } else {
          await FirebaseMessaging.instance.unsubscribeFromTopic('stock_alerts');
        }

        if (_consultationUpdates) {
          await FirebaseMessaging.instance
              .subscribeToTopic('consultation_updates');
        } else {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic('consultation_updates');
        }

        if (_orderUpdates) {
          await FirebaseMessaging.instance.subscribeToTopic('order_updates');
        } else {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic('order_updates');
        }
      }
    } catch (e) {
      print('Error updating FCM settings: $e');
    }
  }

  Future<void> _testNotification() async {
    setState(() => _isLoading = true);

    try {
      await SettingsService().sendTestNotification();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال إشعار تجريبي'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في إرسال الإشعار: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الإشعارات'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveSettings,
            tooltip: 'حفظ',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Notification Types
          _buildSectionTitle('أنواع الإشعارات'),
          const SizedBox(height: 8),
          _buildCard([
            _buildSwitchTile(
              title: 'تذكيرات الأدوية',
              subtitle: 'إشعارات مواعيد تناول الأدوية',
              value: _medicationReminders,
              icon: Icons.medication_outlined,
              iconColor: Colors.blue,
              onChanged: (value) {
                setState(() => _medicationReminders = value);
              },
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              title: 'تنبيهات المخزون',
              subtitle: 'تنبيهات عند نفاد الأدوية',
              value: _stockAlerts,
              icon: Icons.inventory_2_outlined,
              iconColor: Colors.orange,
              onChanged: (value) {
                setState(() => _stockAlerts = value);
              },
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              title: 'تحديثات الاستشارات',
              subtitle: 'ردود الأطباء والرسائل الجديدة',
              value: _consultationUpdates,
              icon: Icons.chat_bubble_outline,
              iconColor: Colors.green,
              onChanged: (value) {
                setState(() => _consultationUpdates = value);
              },
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              title: 'تحديثات الطلبات',
              subtitle: 'حالة الطلبات والتوصيل',
              value: _orderUpdates,
              icon: Icons.shopping_bag_outlined,
              iconColor: Colors.purple,
              onChanged: (value) {
                setState(() => _orderUpdates = value);
              },
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              title: 'إشعارات عامة',
              subtitle: 'أخبار وتحديثات التطبيق',
              value: _generalNotifications,
              icon: Icons.notifications_outlined,
              iconColor: Colors.teal,
              onChanged: (value) {
                setState(() => _generalNotifications = value);
              },
            ),
          ]),

          const SizedBox(height: 24),

          // Notification Behavior
          _buildSectionTitle('سلوك الإشعارات'),
          const SizedBox(height: 8),
          _buildCard([
            _buildSwitchTile(
              title: 'الصوت',
              subtitle: 'تشغيل صوت مع الإشعارات',
              value: _soundEnabled,
              icon: Icons.volume_up_outlined,
              iconColor: Colors.indigo,
              onChanged: (value) {
                setState(() => _soundEnabled = value);
              },
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              title: 'الاهتزاز',
              subtitle: 'اهتزاز الجهاز عند الإشعارات',
              value: _vibrationEnabled,
              icon: Icons.vibration,
              iconColor: Colors.pink,
              onChanged: (value) {
                setState(() => _vibrationEnabled = value);
              },
            ),
          ]),

          const SizedBox(height: 24),

          // Test Notification
          _buildSectionTitle('اختبار'),
          const SizedBox(height: 8),
          _buildCard([
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              title: const Text(
                'إرسال إشعار تجريبي',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'اختبر إعدادات الإشعارات',
                style: TextStyle(fontSize: 13),
              ),
              trailing: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(
                Icons.send,
                color: Colors.amber,
              ),
              onTap: _isLoading ? null : _testNotification,
            ),
          ]),

          const SizedBox(height: 24),

          // Important Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ملاحظة مهمة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'يجب السماح للتطبيق بإرسال الإشعارات من إعدادات الجهاز لتلقي التنبيهات.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Color iconColor,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
