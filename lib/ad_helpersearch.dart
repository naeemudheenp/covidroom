import 'dart:io';

class AdHelpersearch {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6480505866670634/2083610736';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9497161130845867/1754182526';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6480505866670634~1023123587";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}