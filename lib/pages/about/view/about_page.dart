import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/web.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pomo/l10n/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  'Pomo',
                  style: Theme.of(context).textTheme.headlineLarge,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
