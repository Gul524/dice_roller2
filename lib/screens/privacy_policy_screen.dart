import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_info.dart';
import '../config/app_sizes.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link. Please try manually.')),
        );
      }
    }
  }

  Future<void> _launchEmail(BuildContext context) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: AppInfo.developerEmail,
        query: 'subject=Dice Roller - Privacy Inquiry',
      );
      await launchUrl(uri);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No email app found. Contact us at: ${AppInfo.developerEmail}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          children: [
            // Open in browser card
            _buildActionCard(
              context,
              icon: Icons.open_in_browser,
              title: 'View Online',
              subtitle: 'Open full policy in your browser',
              onTap: () => _launchUrl(context, AppInfo.privacyPolicyUrl),
            ),

            const SizedBox(height: AppSizes.paddingM),

            // Full policy text
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Privacy Policy for Dice Roller'),
                  _buildParagraph(
                    context,
                    'Effective date: March 25, 2026',
                    isSubtitle: true,
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Summary'),
                  _buildParagraph(
                    context,
                    '• Dice Roller works without user accounts and without collecting personal information directly.\n'
                    '• The app stores gameplay and settings preferences locally on your device.\n'
                    '• The app may connect to app store services to check for newer versions.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Information We Collect'),
                  _buildSubTitle(context, '1) Information stored locally on your device'),
                  _buildParagraph(
                    context,
                    'Dice Roller saves the following preferences locally using on-device storage (SharedPreferences):\n\n'
                    '• Sound on/off\n'
                    '• Theme mode (Light / Dark / System)\n'
                    '• Dice size and dice limit\n'
                    '• Number of players\n'
                    '• Visual/color effect settings\n'
                    '• Other gameplay configuration values\n\n'
                    'This data stays on your device and is used only to restore your preferences.',
                  ),
                  _buildSubTitle(context, '2) Information not directly collected by us'),
                  _buildParagraph(
                    context,
                    'We do NOT require account registration and do NOT directly collect personal data such as name, email address, phone number, precise location, contacts, or photos/media files.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Third-Party Services'),
                  _buildParagraph(
                    context,
                    'Dice Roller uses the following third-party packages/libraries:\n\n'
                    '• Flutter framework and related platform components\n'
                    '• upgrader (app update check)\n'
                    '• audioplayers (local audio playback)\n'
                    '• package_info_plus (app version/build info)\n\n'
                    'When update-check functionality runs, app store/platform services may process technical request data (e.g. IP address or user agent) according to their own privacy policies. We do not control third-party processing.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Permissions'),
                  _buildParagraph(
                    context,
                    'Dice Roller does not request sensitive runtime permissions such as camera, microphone, location, contacts, or SMS.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Data Sharing'),
                  _buildParagraph(
                    context,
                    'We do not sell personal data and we do not share user personal information for advertising purposes.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Data Retention & Deletion'),
                  _buildParagraph(
                    context,
                    'Preference data remains on your device until you clear app data or uninstall the app. Uninstalling the app typically removes all local app data from your device.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, "Children's Privacy"),
                  _buildParagraph(
                    context,
                    'Dice Roller is a casual game utility and is not intended to collect personal information from children.',
                  ),
                  _buildDivider(),

                  _buildSectionTitle(context, 'Changes to This Policy'),
                  _buildParagraph(
                    context,
                    'We may update this Privacy Policy from time to time. The updated version will be posted with a new effective date.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.paddingM),

            // Contact card
            _buildActionCard(
              context,
              icon: Icons.email_outlined,
              title: 'Contact Developer',
              subtitle: AppInfo.developerEmail,
              onTap: () => _launchEmail(context),
            ),

            const SizedBox(height: AppSizes.paddingL),

            // Developer info footer
            Center(
              child: Text(
                '© 2026 ${AppInfo.developerName}. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.textTheme.bodySmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingS),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: Icon(icon, color: colorScheme.primary, size: AppSizes.iconM),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.primary,
              size: AppSizes.iconM,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.paddingS, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: theme.textTheme.titleMedium?.color,
        ),
      ),
    );
  }

  Widget _buildSubTitle(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text,
      {bool isSubtitle = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSubtitle ? 12 : 13,
          height: 1.5,
          color: isSubtitle
              ? theme.textTheme.bodySmall?.color
              : theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingS),
      child: Divider(height: 1),
    );
  }
}
