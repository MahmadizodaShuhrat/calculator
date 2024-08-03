import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Claculator extends StatefulWidget {
  const Claculator({super.key});

  @override
  State<Claculator> createState() => _ClaculatorState();
}

class _ClaculatorState extends State<Claculator> {
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor, var razmer) {
    return Container(
      
      alignment: Alignment.center,
        child: ElevatedButton(

      onPressed: () {
        calculation(btntxt);
      },
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: razmer,
          color: txtcolor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: btncolor,
        padding: EdgeInsets.all(20),
minimumSize: Size(95,90)
      ),
    ));
  }

  Widget nol(String btnText) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[850],
          alignment: Alignment.center,
          shape: StadiumBorder(),
          padding: const EdgeInsets.fromLTRB(34, 10, 120, 20)),
      onPressed: () {
        calculation(btnText);
      },
      child: Text(
        '0',
        style: TextStyle(color: Colors.white, fontSize: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                    maxFontSize: 100,
                    minFontSize: 80,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black, 20.0),
                calcButton('+/-', Colors.grey, Colors.black, 20.0),
                calcButton('%', Colors.grey, Colors.black, 35.0),
                calcButton('/', Colors.amber[700]!, Colors.white, 35.0),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('8', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('9', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('x', Colors.amber[700]!, Colors.white, 35.0),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('5', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('6', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('-', Colors.amber[700]!, Colors.white, 35.0),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('2', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('3', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('+', Colors.amber[700]!, Colors.white, 35.0),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                nol('0'),
                calcButton('.', Colors.grey[850]!, Colors.white, 35.0),
                calcButton('=', Colors.amber[700]!, Colors.white, 35.0),
              ],
            )
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
