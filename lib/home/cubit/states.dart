abstract class AppStates {}

class AppInitState extends AppStates {}

class AppLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataFailedState extends AppStates {
  String? error;

  GetUserDataFailedState(this.error);
}

class UpdateEmailVerificationState extends AppStates {}
