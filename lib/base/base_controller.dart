
import 'package:field_force_app/base/user.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {

  late final User? user;

  onApiError();
  onRequestTimeout();
  onInternetUnavailable();
  onNetworkUnavailable();
  onInternetAvailable();

}