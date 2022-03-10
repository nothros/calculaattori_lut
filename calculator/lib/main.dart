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
  //TÄMÄ RAKENTAA UUDEN BUTTONIN NÄYTTÖÖN CONTAINER EI EHKÄ VÄLTTÄMÄTÖN?
  //CONTAINERIIN SAA MARGINIT
  Widget buildButton(String buttonText) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 60),
            shape: const CircleBorder(),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    ));
  }

  //TÄMÄ RAKENTAA UUDEN OPERANDBUTTONIN NÄYTTÖÖN CONTAINER EI EHKÄ VÄLTTÄMÄTÖN?
  //KATOAAKO VÄRI JOS CONTAINERIN JÄTTÄÄ POIS?
  Widget operandButton(String operand) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.orange,
      child: MaterialButton(
        onPressed: () => {},
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
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                alignment: Alignment.centerRight,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                )),
            Column(children: [
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
          ],
        ));
  }
}
