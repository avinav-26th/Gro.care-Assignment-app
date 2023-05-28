import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextStyle textStyle1 = const TextStyle(
        color: Color(0xff029DD7),
        fontSize: 22,
      ),
      textStyle2 = const TextStyle(
        color: Color(0xff6FB84D),
        fontSize: 22,
      );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 80,
              ),
              child: Image.asset('assets/images/wybe_logo_v3.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('W', style: textStyle1),
                Text(
                  'hen',
                  style: textStyle2,
                ),
                Text(
                  ' You',
                  style: textStyle1,
                ),
                Text(
                  '\'re',
                  style: textStyle2,
                ),
                Text(
                  ' B',
                  style: textStyle2,
                ),
                Text(
                  'o',
                  style: textStyle1,
                ),
                Text(
                  'red',
                  style: textStyle2,
                ),
                Text(
                  ' Enoug',
                  style: textStyle1,
                ),
                Text(
                  'h',
                  style: textStyle2,
                ),
              ],
            ),const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'just ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'W',
                  style: textStyle2,
                ),
                Text(
                  'Y',
                  style: textStyle1,
                ),
                Text(
                  'B',
                  style: textStyle2,
                ),
                Text(
                  'E',
                  style: textStyle1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
