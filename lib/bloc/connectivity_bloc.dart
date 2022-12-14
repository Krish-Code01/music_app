import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityBloc {
  StreamController _connectivityController;
  StreamSink<ConnectivityResult> get finalSink => _connectivityController.sink;
  Stream<ConnectivityResult> get finalStream => _connectivityController.stream;

  ConnectivityBloc() {
    _connectivityController = StreamController<ConnectivityResult>.broadcast();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityController.add(result);
    });
  }
  void checkConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    _connectivityController.add(connectivityResult);
  }

  dispose() {
    _connectivityController?.close();
  }
}
