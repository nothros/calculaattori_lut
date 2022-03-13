import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome calculator',
      theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey[700]),
      home: const MyHomePage(title: 'Awesome calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Näitä tarvii näyttö
  String output = "0";
  String _output = "";
  String lastOutput = "0";
  String currentNumber = "0"; //pitää kirjaa nykyisestä luvusta
  List<double> givenNumbers = []; //luvut listana
  num sum = 0;


  removeLastLetter(){
     if(_output.length <=1 ){
        _output = "";
      }else{
        String toinen = _output.substring(0, _output.length-1);
        _output = toinen;
      }
  }

  //Buttonlogiikka
  buttonPressed(String buttonText) {

    if(buttonText == "C"){
      removeLastLetter();
      if(_output.isEmpty){
        _output = "0";
      }
    }
    else if (buttonText == "=") {
      String numbers = "";
      double summa = 0;
      if(lastOutput == "-"){
        removeLastLetter();
      }
      String apu=_output.replaceAll("-", "+-");
      var array = apu.split("+").where((s) => s.isNotEmpty).toList();
      for (var n in array) {
        summa += double.parse(n);
      }
      numbers=summa.toString();
      _output = numbers;
      lastOutput="=";
    }

    else if(buttonText == "+"){
      if(lastOutput != "+"){
        if(lastOutput == "-"|| _output == "0"){
          removeLastLetter();
        }
        lastOutput="+";
        _output += buttonText;
      }
    }

    else if(buttonText == "-"){
      if(lastOutput != "-"){
        if(lastOutput == "+"|| _output == "0"){
          removeLastLetter();
        }
        lastOutput="-";
        _output += buttonText;
      }
    }

    else if(buttonText == "."){
      if(!currentNumber.contains(".")){
      currentNumber+=buttonText;
      _output+=buttonText;
      }
    }

    else{
      if(_output =="+" ||_output =="0"){
        _output="";
      }
    lastOutput=buttonText;
    _output+=buttonText;
     }
    setState(() {
      output = _output;
    });
  }

  //Ruutukokofunkkarit, näitä käyttää numeronäyttö, toistaiseksi näin
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }
  //Funkkarit loppuu

  //Näyttö
  Widget buildTextArea() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 22.0),
        //        padding: const EdgeInsets.all(10.0),
        width: screenWidth(context, dividedBy: 4) * 3 -
            44, //tätä pitää vähän säätää. (luo siis 3/4 näyttöä leveen)
        height: 120, //tätä pitää vähän säätää. (1/5 näyttöä korkea)
        decoration: 
        BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.lightGreen[600],
          boxShadow: [BoxShadow(color: Color.fromARGB(255, 85, 139, 47), offset: Offset(4.0, 4.0), blurRadius: 15, spreadRadius: 20,)]
        ),
        alignment: Alignment.bottomRight,
        child: FittedBox(
          child: Text(
            output,
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        )));
  }

  //Numerobuttonit
  Widget buildButton(String buttonText) {
    if (buttonText == "C") {
      return Expanded(
          child: Container(
        child: ElevatedButton(
          child: Text(buttonText),
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
              primary: Colors.orange[800],
              minimumSize: const Size(90, 90),
              shape: const CircleBorder(),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ),
      ));
    }
    return Expanded(
        child: Container(
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey[900],
            minimumSize: const Size(90, 90),
            shape: const CircleBorder(),
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 224, 178),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
      ),
    ));
  }

  //Operandibuttonit vielä säätöä
  Widget operandButton(String operand) {
    if (operand == "=") {
      return Expanded(
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.orange[700],
        ),
        margin: const EdgeInsets.all(10.0),
        child: MaterialButton(
          height: 50,
          onPressed: () => buttonPressed(operand),
          child: Text(
            operand,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ));
    }

    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.orange[200],
      ),
      child: MaterialButton(
        height: 50,
        onPressed: () => buttonPressed(operand),
        child: Text(
          operand,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Numeronäyttö
                  Row(children: [
                    buildTextArea(),
                  ]),
                  //Numeronäyttö loppuu
                  Row(children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    operandButton("-"),
                  ]),
                  Row(children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    operandButton("+"),
                  ]),
                  Row(children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    const Expanded(
                        child: Text('')), //Dummy, pitää rivit samanleveyisinä
                  ]),
                  Row(children: [
                    buildButton("C"),
                    buildButton("0"),
                    buildButton("."),
                    operandButton("="),
                  ])
                ])));
  }
}
