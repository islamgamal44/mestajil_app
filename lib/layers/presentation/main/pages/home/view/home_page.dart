// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../app/di.dart';
import '../../../../../domain/model/models.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/color_manger.dart';
import '../../../../resources/routes_manger.dart';
import '../../../../resources/strings_manger.dart';
import '../../../../resources/values_manger.dart';
import '../viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outPutState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outPutHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBannerWidget(snapshot.data?.banners),
              _getSection(AppStrings.services),
              _getServicesWidget(snapshot.data?.services),
              _getSection(AppStrings.stores),
              _getStoresWidget(snapshot.data?.stores)
            ],
          );
        });
  }

  Widget _getBannerWidget(List<BannerAD>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: Card(
                        elevation: AppSize.s1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManger.primary, width: AppSize.s1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            banner.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
          ));
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p12,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManger.white, width: AppSize.s1)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s120,
                              height: AppSize.s120,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: AppPadding.p8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  service.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
                crossAxisCount: AppSize.s2,
                crossAxisSpacing: AppSize.s8,
                mainAxisSpacing: AppSize.s8,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(stores.length, (index) {
                  return InkWell(
                    onTap: () {
                      //navigate to store details screen
                      Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                    },
                    child: Card(
                      elevation: AppSize.s4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
