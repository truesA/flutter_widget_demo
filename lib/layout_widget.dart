import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * Row({
    ...
    TextDirection textDirection,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    VerticalDirection verticalDirection = VerticalDirection.down,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    List<Widget> children = const <Widget>[],
    })

    textDirection：表示水平方向子widget的布局顺序(是从左往右还是从右往左)，
    默认为系统当前Locale环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)。

    mainAxisSize：表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，
    表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，
    Row的宽度始终等于水平方向的最大宽度；而MainAxisSize.min表示尽可能少的占用水平空间，当子widgets没有占满水平剩余空间，
    则Row的实际宽度等于所有子widgets占用的的水平空间；

    mainAxisAlignment：表示子Widgets在Row所占用的水平空间内对齐方式，
    如果mainAxisSize值为MainAxisSize.min，则此属性无意义，因为子widgets的宽度等于Row的宽度。
    只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义，MainAxisAlignment.start表示沿textDirection的初始方向对齐，
    如textDirection取值为TextDirection.ltr时，则MainAxisAlignment.start表示左对齐，textDirection取值为TextDirection.rtl时表示从右对齐。
    而MainAxisAlignment.end和MainAxisAlignment.start正好相反；MainAxisAlignment.center表示居中对齐。
    读者可以这么理解：textDirection是mainAxisAlignment的参考系。

    verticalDirection：表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down，表示从上到下。

    crossAxisAlignment：表示子Widgets在纵轴方向的对齐方式，Row的高度等于子Widgets中最高的子元素高度，
    它的取值和MainAxisAlignment一样(包含start、end、 center三个值)，不同的是crossAxisAlignment的参考系是verticalDirection，
    即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，verticalDirection值为VerticalDirection.up时，
    crossAxisAlignment.start指底部对齐；而crossAxisAlignment.end和crossAxisAlignment.start正好相反；
    children ：子Widgets数组。
 */
class LayoutDemo extends StatefulWidget {
  @override
  _LayoutDemoState createState() => new _LayoutDemoState();
}

class _LayoutDemoState extends State<LayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("布局widget"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(" Row 布局 "),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(" I am Jack "),
              ],
            ),
            OutlineButton(
              child: Text(
                " 弹性布局 Flex Expanded",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => FlexLayoutTestRoute()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FlexLayoutTestRoute extends StatefulWidget {
  @override
  _FlexLayoutTestRouteState createState() => new _FlexLayoutTestRouteState();
}

class _FlexLayoutTestRouteState extends State<FlexLayoutTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹性布局 Flex Expanded"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          //Flex的两个子widget按1：2来占据水平空间
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30.0,
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
