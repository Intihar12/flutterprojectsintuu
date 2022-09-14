
import 'dart:async';

import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:flutter/material.dart';

class ProgressTimerWidget extends StatefulWidget {
  Function callback;
  ProgressTimerWidget(this.callback);
  @override
  _ProgressTimerWidgetState createState() => _ProgressTimerWidgetState();
}

class _ProgressTimerWidgetState extends State<ProgressTimerWidget> {

  late Timer _timer;
  int _start = 90;
  final TWO_PI = 3.14 * 2;
  final double size = 70;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer =  Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start <= 0) {
            widget.callback();
            timer.cancel();

          } else {
            _start = _start - 1;
          }
        }));
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: TweenAnimationBuilder(
        tween: Tween(begin:0.0,end: 1.0),
        duration: Duration(seconds: 90),
        builder: (context,value,child){
          return Container(
            width: size,
            height: size,
            // color: MyColors.yellow400,
            child: Stack(
              children:[
                ShaderMask(
                  shaderCallback: (rect){
                    return SweepGradient(
                      startAngle: 0,
                      endAngle: TWO_PI,
                      stops: [double.parse(value.toString()),double.parse(value.toString())],
                      center: Alignment.center,
                      colors: [
                        Theme.of(context).colorScheme.onSecondary, Colors.grey.withAlpha(55)],
                    ).createShader(rect);
                  },
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: size-6,
                    width: size-6,
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('$_start')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}