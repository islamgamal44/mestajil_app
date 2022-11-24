import 'dart:async';

import 'package:mmuussttaaeejjiill/layers/presentation/base/baseviewmodel.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  // LoginViewModel();
  // inputs

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state

    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failureData) => {
                  //left > failure
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failureData.message))

                  // print(failureData.message)
                }, (successData) {
      //right > success

      //content
      inputState.add(ContentState());

      // navigate to home screen
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outIsAreAllInputsValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsAreAllInputsValid;
}
