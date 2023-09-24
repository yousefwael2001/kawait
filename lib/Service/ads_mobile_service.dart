import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2775212057225154/5991212834';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2775212057225154/1571539953';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2775212057225154/9647386812';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2775212057225154/5398555587';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
