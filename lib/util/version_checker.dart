import 'package:flutter/material.dart';
import 'package:movie_mobile/network/movie/request_releases.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/movie/entity/releases.dart';

class VersionChecker {
  void checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    debugPrint("Version is $version");

    requestReleases(3)
        .then((releases) => _compareVersion(context, releases, version))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  void _compareVersion(BuildContext context, List<Release> releases, String version) {
    bool isNewest = (releases[0].tag_name.compareTo(version) == 0);
    String url =
        releases[0].assets.isNotEmpty ? releases[0].assets[0].browser_download_url : releases[0].html_url;
    if (!isNewest) {
      String msg = "Neue Version ${releases[0].tag_name} verfügbar";
      Duration duration = const Duration(seconds: 5);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(duration: duration, content: _buildRow(msg, context, url)));
    }
  }

  Row _buildRow(String msg, BuildContext context, String url) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(msg),
        TextButton(
            onPressed: () => _launchUrl(context, url),
            child: const Text("Öffnen", style: TextStyle(color: Colors.blueAccent)))
      ],
    );
  }

  Future<void> _launchUrl(BuildContext context, String movieURL) async {
    final Uri url = Uri.parse(movieURL);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      _showError(context, url);
    }
  }

  bool _showError(BuildContext context, Uri url) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    return true;
  }
}
