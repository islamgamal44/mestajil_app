import 'dart:async';
import 'dart:ffi';

import 'package:mmuussttaaeejjiill/layers/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/model/models.dart';
import '../../../../../domain/usecase/home_usecase.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInPut, HomeViewModelOutPut {
  final StreamController _dataStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  // inputs //////
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullscreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (failureData) => {
              //left > failure
              inputState.add(ErrorState(
                  StateRendererType.fullscreenErrorState, failureData.message))

              // print(failureData.message)
            }, (homeObject) {
      //right > success

      //content
      inputState.add(ContentState());
      inPutHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inPutHomeData => _dataStreamController.sink;

  // outputs /////////
  @override
  Stream<HomeViewObject> get outPutHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInPut {
  Sink get inPutHomeData;
}

abstract class HomeViewModelOutPut {
  Stream<HomeViewObject> get outPutHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAD> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
