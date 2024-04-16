import 'package:education_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimer = 'first-timer';

class OnBoardingLocalDataSourceImplementation
    implements OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImplementation(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(
        kFirstTimer,
        false,
      );
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _prefs.getBool(kFirstTimer) ?? true;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }
}
