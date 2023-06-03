import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sorted/utils/colors.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 10);

  void startTimer() async {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) async {
      final reduceSecondsBy = 1;
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    });
    Timer(Duration(seconds: 10), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Timer Ended'),
            content: Text('The timer has ended.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void resetTimer() {
    setState(() => myDuration = const Duration(seconds: 10));
  }

  Future<void> setCountDown() async {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$hours:$minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: TextButton(
                onPressed: () {
                  startTimer();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryDarkBlueColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  disabledBackgroundColor: secondaryDarkGreyColor,
                  disabledForegroundColor: secondaryGreyColor,
                ),
                child: Text(
                  'Start Timer',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: TextButton(
                onPressed: () {
                  resetTimer();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryDarkBlueColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  disabledBackgroundColor: secondaryDarkGreyColor,
                  disabledForegroundColor: secondaryGreyColor,
                ),
                child: Text(
                  'Reset Timer',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
