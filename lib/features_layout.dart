import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/text_style_m.dart';

class FeaturesWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("功能型Widget"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                child: Text(
                  "导航返回拦截WillPopScope",
                  style: TextStyleMs.black_28,
                ),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WillPopScopeDemo()));
                },
              ),
              OutlineButton(
                child: Text(
                  "InheritedWidget数据共享",
                  style: TextStyleMs.black_28,
                ),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InheritedWidgetDemo()));
                },
              ),
              OutlineButton(
                child: Text(
                  "主题 ThemeData",
                  style: TextStyleMs.black_28,
                ),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThemeDataDemo()));
                },
              ),
            ],
          ),
        ));
  }
}
// ignore: slash_for_doc_comments
/**
 * const WillPopScope({
    ...
    @required WillPopCallback onWillPop,
    @required Widget child
    })

    onWillPop是一个回调函数，当用户点击返回按钮时调用（包括导航返回按钮及Android物理返回按钮），
    该回调需要返回一个Future对象，如果返回的Future最终值为false时，
    则当前路由不出栈(不会返回)，最终值为true时，当前路由出栈退出。
    我们需要提供这个回调来决定是否退出。
 */

class WillPopScopeDemo extends StatefulWidget {
  @override
  _WillPopScopeDemoState createState() => new _WillPopScopeDemoState();
}

class _WillPopScopeDemoState extends State<WillPopScopeDemo> {
  DateTime _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("导航返回拦截WillPopScope"),
      ),
      body: WillPopScope(
          child: Container(
            alignment: Alignment.center,
            child: Text("1秒内连续按两次返回键退出"),
          ),
          onWillPop: () async {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();
              return false;
            }
            return true;
          }),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * InheritedWidget
 */
class InheritedWidgetDemo extends StatefulWidget {
  @override
  _InheritedWidgetDemoState createState() => new _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("InheritedWidgetDemo"),
      ),
      body: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: TextChildDemo(), //子widget中依赖ShareDataWidget
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text("Increment +"),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (count > 0) {
                      count--;
                    }
                  });
                },
                child: Text("Increment -"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  int data; //需要在子树中共享的数据，保存点击次数

  ShareDataWidget({Key key, @required this.data, Widget child})
      : super(key: key, child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    //如果返回false，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}

class TextChildDemo extends StatefulWidget {
  @override
  _TextChildDemoState createState() => new _TextChildDemoState();
}

class _TextChildDemoState extends State<TextChildDemo> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。

    //可以启动小部件的网络请求
    print("Dependencies change");
  }
}

// ignore: slash_for_doc_comments
/**
 * 主题 ThemeData
 *
 * ThemeData({
    Brightness brightness, //深色还是浅色
    MaterialColor primarySwatch, //主题颜色样本，见下面介绍
    Color primaryColor, //主色，决定导航栏颜色
    Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
    Color cardColor, //卡片颜色
    Color dividerColor, //分割线颜色
    ButtonThemeData buttonTheme, //按钮主题
    Color cursorColor, //输入框光标颜色
    Color dialogBackgroundColor,//对话框背景颜色
    String fontFamily, //文字字体
    TextTheme textTheme,// 字体主题，包括标题、body等文字样式
    IconThemeData iconTheme, // Icon的默认样式
    TargetPlatform platform, //指定平台，应用特定平台控件风格
    ...
    })
    上面只是ThemeData的一小部分属性，完整列表读者可以查看SDK定义。
    上面属性中需要说明的是primarySwatch，它是主题颜色的一个"样本"，
    通过这个样本可以在一些条件下生成一些其它的属性，例如，如果没有指定primaryColor，
    并且当前主题不是深色主题，那么primaryColor就会默认为primarySwatch指定的颜色，
    还有一些相似的属性如accentColor 、indicatorColor等也会受primarySwatch影响。
 */
class ThemeDataDemo extends StatefulWidget {
  @override
  _ThemeDataDemoState createState() => new _ThemeDataDemoState();
}

class _ThemeDataDemoState extends State<ThemeDataDemo> {
  Color _themeColor = Colors.teal; //当前路由主题色
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
        data: ThemeData(
            primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
            iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
            ),
        child: new Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("主题 ThemeData"),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //第一行Icon使用主题中的iconTheme
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("  颜色跟随主题")
                    ]),
                //为第二行Icon自定义颜色（固定为黑色)
                Theme(
                  data: themeData.copyWith(
                    iconTheme:
                        themeData.iconTheme.copyWith(color: Colors.black),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.airport_shuttle),
                        Text("  颜色固定黑色")
                      ]),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: Icon(Icons.thumb_up),
          ),
        ));
  }
}
