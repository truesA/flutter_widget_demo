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
            OutlineButton(
              child: Text(
                "流式布局 Wrap",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => WrapDemo()));
              },
            ),
            OutlineButton(
              child: Text(
                "层叠布局 Stack ",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => StackDemo()));
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
          ),

          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 100.0,
              //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30.0,
                      color: Colors.blue,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Wrap({
    ...
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    List<Widget> children = const <Widget>[],
    })
 */
class WrapDemo extends StatefulWidget {
  @override
  _WrapDemoState createState() => new _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("弹性布局 Flex Expanded"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
              new Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('A')),
                label: GestureDetector(
                  child: new Text('Hamilton'),
                  onTap: () {
                    print("111");
                  },
                ),
              ),
              new Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('M')),
                label: new Text('Lafayette'),
              ),
              new Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('H')),
                label: new Text('Mulligan'),
              ),
              new Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('J')),
                label: new Text('Laurens'),
              ),
            ],
          ),
          Flow(
            delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
            children: <Widget>[
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.red,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.green,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.blue,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.yellow,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.brown,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.purple,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
      }
      x += context.getChildSize(i).width + margin.left + margin.right;
    }
  }

  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

// ignore: slash_for_doc_comments
/**
 * Stack({
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.overflow = Overflow.clip,
    List<Widget> children = const <Widget>[],
    })

    alignment：此参数决定如何去对齐没有定位（没有使用Positioned）
    或部分定位的子widget。所谓部分定位，在这里特指没有在某一个轴上定位：
    left、right为横轴，top、bottom为纵轴，
    只要包含某个轴上的一个定位属性就算在该轴上有定位。
    textDirection：和Row、Wrap的textDirection功能一样，
    都用于决定alignment对齐的参考系即：textDirection的值为TextDirection.ltr，
    则alignment的start代表左，end代表右；textDirection的值为TextDirection.rtl，则alignment的start代表右，end代表左。
    fit：此参数用于决定没有定位的子widget如何去适应Stack的大小。
    StackFit.loose表示使用子widget的大小，StackFit.expand表示扩伸到Stack的大小。
    overflow：此属性决定如何显示超出Stack显示空间的子widget，
    值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。

    const Positioned({
    Key key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    @required Widget child,
    left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离。
    width和height用于指定定位元素的宽度和高度，注意，
    此处的width、height 和其它地方的意义稍微有点区别，
    此处用于配合left、top 、right、 bottom来定位widget，
    举个例子，在水平方向时，你只能指定left、right、width三个属性中的两个，
    如指定left和width后，right会自动算出(left+width)，
    如果同时指定三个属性则会报错，垂直方向同理。
    })
 */
class StackDemo extends StatefulWidget {
  @override
  _StackDemoState createState() => new _StackDemoState();
}

class _StackDemoState extends State<StackDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Stack和绝对定位"),
        ),
        body:
            //通过ConstrainedBox来确保Stack占满屏幕
            ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child:
//          Stack(
//            alignment: Alignment.center,
//            children: <Widget>[
//              Container(
//                color: Colors.blue,
//                child: Text(
//                  "Hello world",
//                  style: TextStyle(color: Colors.white),
//                ),
//              ),
//              Positioned(left: 18.0, child: Text("I am Jack")),
//              Positioned(
//                top: 18.0,
//                child: Text("Your friend"),
//              )
//            ],
//          ),
                    Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned(
                      left: 18.0,
                      child: Text("I am Jack"),
                    ),
                    Container(
                      child: Text("Hello world",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                    Positioned(
                      top: 18.0,
                      child: Text("Your friend"),
                    )
                  ],
                )));
  }
}
