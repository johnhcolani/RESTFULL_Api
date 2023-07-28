import 'package:api_test/widgets/sympsons_character.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/simpsons_api_service.dart';
import '../resources/color_manager.dart';

class WebViewApp extends StatefulWidget {
  final String character;
  final String characterName;

  const WebViewApp({required this.character, Key? key, required this.characterName}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {

  late final WebViewController controller;

  @override
  void initState() {

    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.character),
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkBlue,
        title:  Center(child: Text(widget.characterName ?? "",style: TextStyle(color: ColorManager.white),)),
      ),
      body: WebViewWidget(

        controller: controller,
      ),
    );
  }
}
