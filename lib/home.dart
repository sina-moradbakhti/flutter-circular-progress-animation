import 'package:circularprogressanimated/circularProgressbarAnimation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextStyle _textStyle1 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey);

  double _to = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressbarWithAnimation(
            duration: const Duration(seconds: 2),
            symbol: '%',
            from: 0,
            to: _to,
            innerStrokeColor: Colors.purpleAccent,
            strokeColor: Colors.grey.shade300,
            innerStrokeWidth: 15,
            strokeWidth: 5,
            colorConditions: [
              ColorRule(
                color: Colors.redAccent,
                rangeIndex: [21, 40],
              ),
              ColorRule(
                color: Colors.grey.shade400,
                rangeIndex: [0, 20],
              ),
              ColorRule(
                color: Colors.purpleAccent,
                rangeIndex: [41, 97],
              ),
              ColorRule(
                color: Colors.green,
                rangeIndex: [98, 100],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final button in _buttons()) button,
              ],
            ),
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
              _to = 40;
            });
          },
          child: Text(
            '40%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 12.6;
            });
          },
          child: Text(
            '12.6%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 78.35;
            });
          },
          child: Text(
            '78.35%',
            style: _textStyle1,
          )),
      TextButton(
          onPressed: () {
            setState(() {
              _to = 100;
            });
          },
          child: Text(
            '100%',
            style: _textStyle1,
          )),
    ];
  }
}
