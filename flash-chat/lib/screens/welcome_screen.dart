import 'package:flash_chat_new/screens/login_screen.dart';
import 'package:flash_chat_new/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_new/components/flash_chat_button.dart';

class WelcomeScreen extends StatefulWidget {

  static const id = 'welcome';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  late final animator = AnimationController(
    duration: const Duration(seconds: 1), // Question: why does this crash without duration even though duration is not required? 🤦🏼‍♂️
    vsync: this, // Question: why does this not cause a retain cycle??
  );

  late final animation = ColorTween(
    begin: Colors.blue, 
    end: Colors.white
  )
  .animate(animator);

  @override
  void initState() {
    super.initState();

    animator.addListener(() { setState(() {}); });
    animator.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo_hero_tag',
                    child: Container(
                      height: animator.value * 60,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                ]),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            FlashChatButton(
              title: 'Log In', 
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.lightBlueAccent
            ),
            FlashChatButton(
              title: 'Register', 
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: Colors.blueAccent
            ),
          ],
        ),
      ),
    );
  }

  String testButtonTitle = 'Test Initializing Firebase';

  @override
  void dispose() {
    animator.dispose(); // Question: how would we supposed to know this shit leaks memory??
    super.dispose();

    // Question: what is the proper destructor / deinitializer of classes?
    // Question: how does memory management work in dart? reference counting or garbage collection?
  }
}

