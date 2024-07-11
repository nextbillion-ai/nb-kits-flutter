part of '../nb_kits_flutter.dart';

class NBKitsMethodChannelsFactory {
  static const MethodChannel _nbKitsFlutterChannel = MethodChannel("nb_kits_flutter");

  static MethodChannel get nbKitsFlutterChannel => _nbKitsFlutterChannel;
}
