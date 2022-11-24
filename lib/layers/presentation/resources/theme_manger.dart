import 'package:flutter/material.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/resources/stayles_manger.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/resources/values_manger.dart';

import 'color_manger.dart';
import 'font_manger.dart';

ThemeData getAppTheme() {
  return ThemeData(
      //main color
      primaryColor: ColorManger.primary,
      primaryColorLight: ColorManger.lightPrimary,
      primaryColorDark: ColorManger.darkPrimary,
      disabledColor: ColorManger.gray1,
      splashColor: ColorManger.lightPrimary, //ripple effect

      //cardView theme
      cardTheme: CardTheme(
        color: ColorManger.white,
        shadowColor: ColorManger.grey,
        elevation: AppSize.s4,
      ),

      //appBar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManger.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManger.lightPrimary,
          titleTextStyle: getRegularStyle(
              fontSize: FontSize.s16, color: ColorManger.white)),
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManger.gray1,
          buttonColor: ColorManger.primary,
          splashColor: ColorManger.lightPrimary),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManger.white, fontSize: FontSize.s16),
              primary: ColorManger.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ))), //elevated button theme

      textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: ColorManger.darkGray, fontSize: FontSize.s22),
        displayMedium: getSemiBoldStyle(
            color: ColorManger.darkGray, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorManger.darkGray, fontSize: FontSize.s14),
        headlineLarge:
            getBoldStyle(color: ColorManger.darkGray, fontSize: FontSize.s14),
        titleMedium:
            getMediumStyle(color: ColorManger.primary, fontSize: FontSize.s14),
        titleLarge:
            getBoldStyle(color: ColorManger.primary, fontSize: FontSize.s18),
        bodyLarge: getRegularStyle(color: ColorManger.gray1),
        bodySmall: getRegularStyle(color: ColorManger.grey),
      ),

      //text theme

      //input decoration theme(textFormField)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle:
            getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManger.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(
          color: ColorManger.error,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManger.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManger.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      ));
}
