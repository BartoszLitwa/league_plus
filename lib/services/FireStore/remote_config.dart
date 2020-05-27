
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRemote {
  static RemoteConfig _remoteConfig;

  static Future<void> setupConfigRemote() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 1));
    await remoteConfig.activateFetched();

    _remoteConfig = remoteConfig;
  }

  static String getRiotApiKey() {
    return _remoteConfig.getString('riot_api_key');
  }
}