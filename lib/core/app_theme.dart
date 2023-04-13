
import 'package:congress/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme(this.context);

  final BuildContext context;

  ThemeData get defaultTheme => ThemeData(
    primaryColor: AppColors.primary,
    backgroundColor: AppColors.gray,
    visualDensity: VisualDensity.adaptivePlatformDensity
  );
}