import 'package:flutter/material.dart';
import 'package:online_store_tk/src/widgets/button_decoration_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtomDecorationWidget(
              text: "INICIAR",
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ),
      ),
    );
  }
}
