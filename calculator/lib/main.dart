import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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


  //Buttoneiden logiikka.
  buttonPressed(String buttonText){
    _output += buttonText;
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

  //Numerobuttonit
  Widget buildButton(String buttonText) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(80, 80),
            shape: const CircleBorder(),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "VT323",)),
      ),
    ));
  }

  //Operandibuttonit vielä säätöä
  Widget operandButton(String operand) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.orange,
      child: MaterialButton(
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
            children: [
              //Numeronäyttö
              Row(children: [Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: screenWidth(context, dividedBy: 4)*3-10, //tätä pitää vähän säätää. (luo siis 3/4 näyttöä leveen)
                height: screenHeight(context, dividedBy: 5),//tätä pitää vähän säätää. (1/5 näyttöä korkea)
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                alignment: Alignment.centerRight,
                child: Text(
                  output,
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ))]),
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
                Expanded(child: Text('')), //PITÄÄ RIVIT SAMANLEVYISINÄ
              ]),
              Row(children: [
                buildButton("C"),
                buildButton("0"),
                buildButton("."),
                operandButton("="),
              ])
            ])

        );
  }
}
