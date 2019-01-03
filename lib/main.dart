import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/scaffold_demo.dart';
import 'package:flutter_widget_demo/textfield_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Widget 练习合集 '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var blackTextStyle =
      new TextStyle(color: const Color(0xFF333333), fontSize: 15.0);

  void _incrementCounter() {
    setState(() {});
  }

  void toScaffold() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ScaffoldDemo()));
  }

  void toTextField() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => TextFieldDemo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
//          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: <Widget>[
            OutlineButton(
              child: Text("Scaffold 脚手架"),
              textColor: Colors.black,
              onPressed: toScaffold,
            ),
            OutlineButton(
              child: Text("TextField 输入"),
              textColor: Colors.black,
              onPressed: toTextField,
            ),
            OutlineButton(
              child: Text(
                "Scaffold",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {},
            ),
            OutlineButton(
              child: Text(
                "Scaffold",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
