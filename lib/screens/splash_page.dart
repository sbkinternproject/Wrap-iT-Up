import '/app_properties.dart';
import '/screens/auth/welcome_back_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
/*
  SingleTickerProviderStateMixin: As the name suggest this is used when you have only one Animation Controller 
  in your widget and its job is to provide with ticker value to the Stateful Widget.

  What is Ticker ???

  When you add your SingleTickerProviderStateMixin, it tells Flutter that there is some animation in this widget 
  and this widget needs to notified about the animation mes of flutter.

  vsync property is related to the Ticker and if the stateful widget has the Mixin, 
  you can pass this to this property.

  Animation with just the controller is possible when your animated value is also from just 0 to 1. 
  You can pass the controller value to the widget and start the animation by calling controller.forward()
*/

  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
/*
  What is vsync ? 
  Vsync basically keeps the track of screen, so that Flutter does not renders
  the animation when the screen is not being displayed.
*/
        duration: Duration(milliseconds: 2500),
        vsync: this);
/*
  Tween: Short for in-betweening, the process of generating intermediate frames between two images to give 
  the appearance that the first image evolves smoothly into the second image.
*/
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
/*
  AddListener() function calls the setState() so as to make the current frame as dirty which ensures 
  that the build() is called again. 
*/
      ..addListener(() {
        setState(() {});
      });

/*
  After Completing we are sending the user to Navigation Page Method
*/
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

/*
  After Splash Screen Sending to Welcome Back Page

  PushReplacement: Replace the current route of the navigator that most tightly encloses the 
  given context by pushing the given route and then disposing the previous route once the new 
  route has finished animating in.
*/
  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: transparentRed),
        child: SafeArea(
          child: new Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: new Image.asset('assets/logo.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Powered by '),
                          TextSpan(
                              text: 'SBK',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
