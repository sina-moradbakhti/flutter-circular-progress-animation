import 'package:circularprogressanimated/circularProgressbarWithAnimation.widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextStyle _textStyle1 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey);

  double _to = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressbarWithAnimation(
              stroke: 5,
              innerStroke: 15,
              from: 0,
              to: _to,
              strokeColor: Colors.grey.shade300,
              innerStrokeColor: Colors.purpleAccent,
              innerStrokeColorList: [
                CircularProgressWithAnimationColor(
                    color: Colors.grey.shade400,
                    index: 0.2,
                    operator:
                        CircularProgressAnimColorOperator.isLowerAndEqual),
                CircularProgressWithAnimationColor(
                    color: Colors.redAccent,
                    index: 0.4,
                    operator:
                        CircularProgressAnimColorOperator.isLowerAndEqual),
                CircularProgressWithAnimationColor(
                    color: Colors.green, index: 1),
              ],
              textStyle: const TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final button in _buttons()) button,
            ],
          ),
        )
      ],
    ));
  }

  List<TextButton> _buttons() {
    return [
      TextButton(
          onPressed: () {
            setState(() {
              _to = 0;
            });
          },
          child: Text(
            '0%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 0.4;
            });
          },
          child: Text(
            '40%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 0.126;
            });
          },
          child: Text(
            '12.6%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 0.7835;
            });
          },
          child: Text(
            '78.35%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 1;
            });
          },
          child: Text(
            '100%',
            style: _textStyle1,
          )),
    ];
  }
}
