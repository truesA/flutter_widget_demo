import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/animation_layout.dart';
import 'package:flutter_widget_demo/container_layout_widget.dart';
import 'package:flutter_widget_demo/features_layout.dart';
import 'package:flutter_widget_demo/layout_widget.dart';
import 'package:flutter_widget_demo/pointer_notification.dart';
import 'package:flutter_widget_demo/scaffold_demo.dart';
import 'package:flutter_widget_demo/scroll_layout.dart';
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

  void toLayoutDemo() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LayoutDemo()));
  }

  ///容器widget
  void toRqLayoutDemo() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ContainerLayoutDemo()));
  }

  void toScrollLayoutDemo() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ScrollViewDemo()));
  }

  void toFeaturesWidgetDemo() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => FeaturesWidgetDemo()));
  }

  void toPointerWidgetDemo() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PointerWidgetDemo()));
  }

  void toAnimationWidgetDemo() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AnimationDemo()));
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
                "布局widget",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: toLayoutDemo,
            ),
            OutlineButton(
              child: Text(
                "容器widget",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: toRqLayoutDemo,
            ),
            OutlineButton(
              child: Text(
                "滚动的widget",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: toScrollLayoutDemo,
            ),
            OutlineButton(
              child: Text(
                "功能型Widget",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: toFeaturesWidgetDemo,
            ),
            OutlineButton(
              child: Text(
                "事件处理与通知",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: toPointerWidgetDemo,
            ),
            OutlineButton(
              child: Text(
                "动画",
                style: blackTextStyle,
              ),
              textColor: Colors.black,
              onPressed: toAnimationWidgetDemo,
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
