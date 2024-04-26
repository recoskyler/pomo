import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/web.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl() async {
    final uri = Uri.parse('https://github.com/recoskyler');

    if (!await launchUrl(uri)) {
      Logger().e('Failed to launch GitHub link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/pomo_logo.svg',
                  width: MediaQuery.of(context).size.shortestSide * 0.4,
                ),
                const SizedBox(height: 16),
                Text(
                  'pOmo',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: 'Major Mono Display',
                      ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError && snapshot.error != null) {
                      Logger().e(
                        'Failed to load package info',
                        error: snapshot.error,
                      );

                      return const SizedBox();
                    }

                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      final packageInfo = snapshot.data!;

                      return TextButton(
                        onLongPress: () => Navigator.pushNamed(
                          context,
                          '/deniz',
                        ),
                        onPressed: () {},
                        child: Text(
                          'v${packageInfo.version}+${packageInfo.buildNumber}',
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: l10n.madeBy1),
                      TextSpan(
                        text: 'recoskyler',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _launchUrl,
                      ),
                      TextSpan(text: l10n.madeBy2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
