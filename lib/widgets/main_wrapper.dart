import 'package:api_test/Screens/home_page.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';


class MainWrapper extends StatelessWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: ColorManager.darkBlue,
        body: const HomePage(characters: [],));
  }
}
