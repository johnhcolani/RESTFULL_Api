import 'package:api_test/Screens/splash_screen.dart';
import 'package:api_test/resources/color_manager.dart';
import 'package:api_test/widgets/sympsons_character.dart';
import 'package:api_test/widgets/the_wire_character.dart';
import 'package:api_test/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCharacterProvider = StateProvider<String>((ref) => 'simpsons');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
        color: ColorManager.orange, // Change the color of the arrow here
        ),),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }

}

