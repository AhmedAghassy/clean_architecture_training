import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnectedToInternet;
}

class NetworkInfoImpInternetConnectionChecker implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpInternetConnectionChecker({
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get isConnectedToInternet =>
      internetConnectionChecker.hasConnection;
}
