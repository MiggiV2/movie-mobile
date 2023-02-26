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
        .then((releases) => compareVersion(context, releases, version))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  void compareVersion(BuildContext context, List<Release> releases, String version) {
    bool isNewest = (releases[0].tag_name.compareTo(version) == 0);
    String url =
        releases[0].assets.isNotEmpty ? releases[0].assets[0].browser_download_url : releases[0].html_url;
    if (isNewest) {
      String msg = "Neue Version ${releases[0].tag_name} verfügbar";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [Text(msg), TextButton(onPressed: () => _launchUrl(context, url), child: Text("Öffnen"))],
      )));
    }
  }

  Future<void> _launchUrl(BuildContext context, String movieURL) async {
    final Uri url = Uri.parse(movieURL);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showError(context, url);
    }
  }

  bool showError(BuildContext context, Uri url) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    return true;
  }
}
