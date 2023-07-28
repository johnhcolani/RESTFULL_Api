import 'dart:async';
import 'package:api_test/resources/color_manager.dart';
import 'package:api_test/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController oneSecondController;
  late Animation<Offset> movingLogoAnimation;
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 4), _goNext);
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainWrapper()));
    // '/MyApp'; (context) => const MyApp();
  }

  @override
  void initState() {
    oneSecondController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    movingLogoAnimation =
        Tween(begin: const Offset(0, 0.4), end: const Offset(0, 0.6)).animate(
            oneSecondController.drive(CurveTween(curve: Curves.elasticIn)));

    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    oneSecondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[

            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              bottom: 400,
              top: 20,
              right: 1,
              left: 1,
              child: SlideTransition(
                position: movingLogoAnimation,
                child: Center(
                  child: Image.asset(
                    "assets/images/back2.png",
                    scale: 1.2,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                  child: Text('Real State',style: GoogleFonts.alexBrush(textStyle:TextStyle(
    fontSize: 40,color: ColorManager.yellow
    ))),
            ),
            )],
        ),
      ),
    );
  }
}
