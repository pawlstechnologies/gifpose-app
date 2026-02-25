import 'dart:async';

class UserActivity {
  static final UserActivity _instance = UserActivity._internal();

  factory UserActivity() => _instance;

  UserActivity._internal();

  late Timer _timer;
  late Function onUserActivity;
  bool _userIsActive = true;

  void startUserActivityTimer() {
    _timer = Timer.periodic(const Duration(minutes: 2), (Timer timer) {
      if (!_userIsActive) {
        onUserActivity();
        timer.cancel();
      }
      _userIsActive = false;
    });
  }

  void onUserInteraction() {
    _userIsActive = true;
    _timer.cancel();
    startUserActivityTimer();
  }
}