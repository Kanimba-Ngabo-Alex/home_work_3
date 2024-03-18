import 'package:flutter/material.dart';
import 'package:midsem/pages/navbar.dart';
import 'package:midsem/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:midsem/theme/theme_provider.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 20,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btncolor,
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.themeData.backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Container(
                color: themeProvider.themeData.backgroundColor,
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: Text(
                          'MENU',
                          style: TextStyle(
                            fontSize: 50,
                            color: themeProvider
                                .themeData.textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 20,
                          color: themeProvider
                              .themeData.textTheme.bodyText1!.color,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_2),
                      title: Text(
                        'About Me',
                        style: TextStyle(
                          fontSize: 20,
                          color: themeProvider
                              .themeData.textTheme.bodyText1!.color,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => UserAbout()),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: themeProvider
                              .themeData.textTheme.bodyText1!.color,
                          fontSize: 30),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('AC', Colors.black, Colors.white),
                  calcbutton('+/-', Colors.black, Colors.white),
                  calcbutton('%', Colors.black, Colors.white),
                  calcbutton(
                      '/', Color.fromARGB(255, 62, 110, 244), Colors.white),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('7', Colors.white, Colors.black),
                  calcbutton('8', Colors.white, Colors.black),
                  calcbutton('9', Colors.white, Colors.black),
                  calcbutton(
                      'x', Color.fromARGB(255, 62, 110, 244), Colors.white),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('4', Colors.white, Colors.black),
                  calcbutton('5', Colors.white, Colors.black),
                  calcbutton('6', Colors.white, Colors.black),
                  calcbutton(
                      '-', Color.fromARGB(255, 62, 110, 244), Colors.white),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('1', Colors.white, Colors.black),
                  calcbutton('2', Colors.white, Colors.black),
                  calcbutton('3', Colors.white, Colors.black),
                  calcbutton(
                      '+', Color.fromARGB(255, 62, 110, 244), Colors.white),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      calculation('0');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(34, 20, 95, 20),
                      shape: StadiumBorder(),
                      primary: Colors.white,
                    ),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  calcbutton('.', Colors.white, Colors.black),
                  calcbutton(
                      '=', Color.fromARGB(255, 62, 110, 244), Colors.white),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
