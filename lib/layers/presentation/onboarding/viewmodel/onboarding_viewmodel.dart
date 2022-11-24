import 'dart:async';

import 'package:mmuussttaaeejjiill/layers/presentation/base/baseviewmodel.dart';

import '../../../domain/model/models.dart';
import '../../resources/assets_manger.dart';
import '../../resources/strings_manger.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controller outputs

  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // on boarding view model inputs

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    {
      return nextIndex;
    }
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    {
      return previousIndex;
    }
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;
  // on boarding view model outputs
  @override
  Stream<SliderViewObject> get outPutSliderViewObject =>
      _streamController.stream.map((event) => event);

  // on boarding private functions

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubTitle1,
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubTitle2,
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubTitle3,
          ImageAssets.onBoardingLogo3,
        ),
        // SliderObject(
        //   AppStrings.onBoardingTitle4,
        //   AppStrings.onBoardingSubTitle4,
        //   ImageAssets.onBoardingLogo4,
        // )
      ];
}

// inputs mean that "orders"
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outPutSliderViewObject;
}
