import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  Future<InitializationStatus> initialization;

  AdService(this.initialization);

  String get bannerAdUnitId => "ca-app-pub-4040965046942345/3790619663";
  String get testBannerAdUnitId => "ca-app-pub-3940256099942544/6300978111";

  BannerAdListener get banAdListener => _banAdListener;

  BannerAdListener _banAdListener = BannerAdListener(
      onAdLoaded: (ad) => print("Ad Loaded: ${ad.adUnitId}"),
      onAdFailedToLoad: (ad, error) =>
          print("Ad Failed To Load: ${ad.adUnitId} : ${error.toString()}"),
      onAdImpression: (ad) => print("Ad Load Impression: ${ad.adUnitId}"));

  // List<String> adUnitIds = [
  // "ca-app-pub-3940256099942544/6300978111", //test
  // "ca-app-pub-3940256099942544/6300978111", //test
  // "ca-app-pub-3940256099942544/6300978111", //test
  // "ca-app-pub-3940256099942544/6300978111", //test
  // "ca-app-pub-3940256099942544/6300978111", //test
  // "ca-app-pub-3940256099942544/6300978111", //test

  //real ads below
  //raisaroj adunits
  // "ca-app-pub-4040965046942345/3790619663",
  // "ca-app-pub-4040965046942345/2221552972",
  // "ca-app-pub-4040965046942345/7538292989",
  // "ca-app-pub-4040965046942345/9908471306",

  //charichainstitute id adunits
  // "ca-app-pub-7811028857602493/3201299019",
  // "ca-app-pub-7811028857602493/3685063485",
  // "ca-app-pub-7811028857602493/5226549320",
  // "ca-app-pub-7811028857602493/1384055976",
  // ];
}
