// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../../resources/values_manger.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });
    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });

    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen

        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
        iconTheme: IconThemeData(color: ColorManger.primary),
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outPutState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p28),
      // color: ColorManger.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image(
                  height: 180,
                  width: 180,
                  image: AssetImage(ImageAssets.splachLogo),
                ),
              ),
              SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outPutErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outPutErrorMobileNumber,
                    builder: (context, snapshot) {
                      return IntlPhoneField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileNumberEditingController,
                        decoration: InputDecoration(
                          labelText: AppStrings.mobileNumber,
                          hintText: AppStrings.mobileNumber,
                          errorText: snapshot.data,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        onCountryChanged: (country) {
                          print(_viewModel.setCountryCode(country.dialCode));
                        },
                      );
                    },
                  ),
                  // child: Row(
                  //   children: [
                  //     Expanded(
                  //         flex: 1,
                  //         child: CountryPickerDropdown(
                  //           // initialValue: 'AR',
                  //           itemBuilder: _buildDropdownItem,
                  //           // itemFilter:
                  //           // ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                  //           priorityList: [
                  //             CountryPickerUtils.getCountryByIsoCode('EG'),
                  //             CountryPickerUtils.getCountryByIsoCode('MO'),
                  //           ],
                  //           // sortComparator: (Country a, Country b) =>
                  //           //     a.isoCode.compareTo(b.isoCode),
                  //           onValuePicked: (Country country) {
                  //             _viewModel.setCountryCode(country.phoneCode);
                  //             print(country.phoneCode);
                  //           },
                  //         )),
                  //     Expanded(
                  //       flex: 4,
                  //       child: StreamBuilder<String?>(
                  //           stream: _viewModel.outPutErrorMobileNumber,
                  //           builder: (context, snapshot) {
                  //             return TextFormField(
                  //               keyboardType: TextInputType.phone,
                  //               controller: _mobileNumberEditingController,
                  //               decoration: InputDecoration(
                  //                   hintText: AppStrings.mobileNumber,
                  //                   labelText: AppStrings.mobileNumber,
                  //                   errorText: snapshot.data),
                  //             );
                  //           }),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outPutErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.emailHint,
                            labelText: AppStrings.emailHint,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outPutErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: Container(
                  height: AppSize.s50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSize.s8,
                      ),
                    ),
                    border: Border.all(color: ColorManger.grey2),
                  ),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s40,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outPutAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(AppStrings.register)),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p18,
                  right: AppPadding.p28,
                  top: AppPadding.p28,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.alreadyHaveAcc,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
              child: Text(
            AppStrings.profilePicture,
            style: TextStyle(color: Colors.black54),
          )),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outPutProfilePicture,
            builder: (context, snapshot) {
              return _imagePicketByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera))
        ],
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  // Widget _buildDropdownItem(Country country) => Container(
  //       child: Row(
  //         children: <Widget>[
  //           CountryPickerUtils.getDefaultFlagImage(country),
  //           // SizedBox(
  //           //   width: 5.0,
  //           // ),
  //           // Text("+${country.phoneCode}(${country.isoCode})"),
  //         ],
  //       ),
  //     );
}
