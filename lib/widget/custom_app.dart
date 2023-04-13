import 'package:congress/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomApp{

  AppBar BarApp(String title){
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(title),
    );
  }


}