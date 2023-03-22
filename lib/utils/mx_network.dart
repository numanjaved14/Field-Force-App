
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

mixin NetworkListener {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


}