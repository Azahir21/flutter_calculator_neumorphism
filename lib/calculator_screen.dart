import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = '';
  String result = '0';

  List<String> buttonList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '⌫',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF374352),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        '=',
                        style: TextStyle(fontSize: 32, color: Colors.redAccent),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                  padding: EdgeInsets.only(top: 8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: buttonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (buttonList[index] == 'C' ||
                        buttonList[index] == '/' ||
                        buttonList[index] == '*' ||
                        buttonList[index] == '-' ||
                        buttonList[index] == '+' ||
                        buttonList[index] == '=' ||
                        buttonList[index] == '⌫') {
                      return _button(buttonList[index], Colors.redAccent);
                    } else {
                      return _button(buttonList[index], Colors.white);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(String _Text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        splashColor: Colors.blueGrey.shade900,
        onTap: () {
          setState(() {
            handleButtons(_Text);
          });
        },
        borderRadius: BorderRadius.circular(40),
        child: Ink(
          decoration: BoxDecoration(
              color: Color(0xFF374352),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                    color: Colors.blueGrey.shade700,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0)
              ]),
          child: Center(
            child: Text(
              _Text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleButtons(String text) {
    if (text == 'C') {
      userInput = '';
      result = '0';
      return;
    }

    if (text == '⌫') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      result = calculate();
      userInput = result;
      if (userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', ' ');
      }
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', ' ');
        return;
      }
    }

    if (text != '=') {
      userInput = userInput + text;
    }
  }

  String calculate() {
    try {
      return userInput.interpret().toString();
    } catch (e) {
      return 'Error';
    }
  }
}
