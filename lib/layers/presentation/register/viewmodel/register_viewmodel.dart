import 'dart:async';
import 'dart:io';

import 'package:mmuussttaaeejjiill/layers/presentation/base/baseviewmodel.dart';

import '../../../app/functions.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/strings_manger.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();

  // StreamController countryMobileCodeStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController emailStreamController = StreamController<String>.broadcast();

  StreamController passwordStreamController =
      StreamController<String>.broadcast();

  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserRegisteredInSuccessfullyStreamController =
      StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();

    mobileNumberStreamController.close();

    emailStreamController.close();

    passwordStreamController.close();

    profilePictureStreamController.close();

    areAllInputsValidStreamController.close();

    isUserRegisteredInSuccessfullyStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register new object

      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.userName,
      registerObject.countryMobileCode,
      registerObject.mobileNumber,
      registerObject.email,
      registerObject.password,
      registerObject.profilePicture,
    )))
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
      // isUserLoggedInSuccessfullyStreamController.add(true);
      isUserRegisteredInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update register new object

      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset countryCode value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      // update register new object

      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register new object

      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register new object

      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      // update register new object

      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  //////////////////////////////////

  // outputs
  @override
  Stream<bool> get outPutIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outPutErrorUserName => outPutIsUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameValid);

  @override
  Stream<bool> get outPutIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outPutErrorEmail => outPutIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailValid);

  @override
  Stream<bool> get outPutIsMobileNumberValid =>
      mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outPutErrorMobileNumber =>
      outPutIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.mobileNumberValid);

  @override
  Stream<bool> get outPutIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outPutErrorPassword => outPutIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordValid);

  @override
  Stream<File> get outPutProfilePicture =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outPutAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // private fun.
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outPutIsUserNameValid;
  Stream<String?> get outPutErrorUserName;

  Stream<bool> get outPutIsMobileNumberValid;
  Stream<String?> get outPutErrorMobileNumber;

  Stream<bool> get outPutIsEmailValid;
  Stream<String?> get outPutErrorEmail;

  Stream<bool> get outPutIsPasswordValid;
  Stream<String?> get outPutErrorPassword;

  Stream<File> get outPutProfilePicture;

  Stream<bool> get outPutAreAllInputsValid;
}
