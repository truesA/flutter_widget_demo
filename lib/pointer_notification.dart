import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/text_style_m.dart';

class PointerWidgetDemo extends StatefulWidget {
  @override
  _PointerWidgetDemoState createState() => new _PointerWidgetDemoState();
}

class _PointerWidgetDemoState extends State<PointerWidgetDemo> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pointer事件处理和通知"),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  OutlineButton(
                    child: Text(
                      "Pointer事件处理",
                      style: TextStyleMs.black_28,
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PointerDemo()));
                    },
                  ),
                  OutlineButton(
                    child: Text(
                      "手势识别GestureDetector",
                      style: TextStyleMs.black_28,
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestureDetectorDemo()));
                    },
                  ),
                  OutlineButton(
                    child: Text(
                      "GestureRecognizer",
                      style: TextStyleMs.black_28,
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestureRecognizerDemo()));
                    },
                  ),
                  OutlineButton(
                    child: Text(
                      "GestureConflict手势竞争和冲突",
                      style: TextStyleMs.black_28,
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestureConflictDemo()));
                    },
                  ),
                  OutlineButton(
                    child: Text(
                      "自定义通知",
                      style: TextStyleMs.black_28,
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationDome()));
                    },
                  ),
                ],
              ),
            )));
  }
}

class PointerDemo extends StatefulWidget {
  @override
  _PointerDemoState createState() => new _PointerDemoState();
}

class _PointerDemoState extends State<PointerDemo> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pointer事件处理"),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Listener"),
                Listener(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue,
                    width: 300.0,
                    height: 150.0,
                    child: Text(_event?.toString() ?? "",
                        style: TextStyle(color: Colors.white)),
                  ),
                  onPointerDown: (PointerEvent event) =>
                      setState(() => _event = event),
                  onPointerUp: (PointerEvent event) =>
                      setState(() => _event = event),
                  onPointerMove: (PointerEvent event) =>
                      setState(() => _event = event),
                ),
                Text(" behavior 属性"),
                Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                Text("deferToChild："
                    "子 widget 会一个接一个的进行命中测试"
                    "，如果子 Widget 中有测试通过的，则当前 Widget 通过，这就意味着，"
                    "如果指针事件作用于子 Widget 上时，其父 (祖先)Widget 也肯定可以收到该事件。"),
                Text("opaque：在命中测试时，将当前 Widget "
                    "当成不透明处理 (即使本身是透明的)，最终的效果相当于当前 Widget 的整个区域都是点击区域。"),
                Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(300.0, 150.0)),
                      child: Center(child: Text("Box A")),
                    ),
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (event) => print("down A")),
                Text("translucent：当点击 Widget 透明区域时，可以对自身边界内及底部可视区域都进行命中测试，"
                    "这意味着点击顶部 widget 透明区域时，顶部 widget 和底部 widget 都可以接收到事件"),
                Stack(
                  children: <Widget>[
                    Listener(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.blue)),
                      ),
                      onPointerDown: (event) => print("down0"),
                    ),
                    Listener(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                        child: Center(child: Text("左上角200*100范围内非文本区域点击 透明")),
                      ),
                      onPointerDown: (event) => print("down1"),
//                        behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
                    ),
                  ],
                ),
                Text("忽略 PointerEvent"),
                Text("假如我们不想让某个子树响应 PointerEvent 的话，"
                    "我们可以使用 IgnorePointer 和 AbsorbPointer，这两个 Widget 都能阻止子树接收指针事件，"
                    "不同之处在于 AbsorbPointer 本身会参与命中测试，而 IgnorePointer 本身不会参与，"
                    "这就意味着 AbsorbPointer "
                    "本身是可以接收指针事件的 (但其子树不行)，而 IgnorePointer 不可以。"),
                Listener(
                  child: AbsorbPointer(
                    child: Listener(
                      child: Container(
                        color: Colors.red,
                        width: 200.0,
                        height: 100.0,
                      ),
                      onPointerDown: (event) => print("子控件收到"),
                    ),
                  ),
                  onPointerDown: (event) => print("AbsorbPointer收到"),
                ),
                Text("点击 Container 时，由于它在AbsorbPointer的子树上"
                    "所以不会响应指针事件，所以日志不会输出 子控件收到，"
                    "但AbsorbPointer本身是可以接收指针事件的，所以会输出AbsorbPointer收到。"
                    "如果将AbsorbPointer换成IgnorePointer，那么两个都不会输出。"),
                Padding(padding: EdgeInsets.only(bottom: 50.0, top: 20.0)),
              ],
            ),
          )),
    );
  }
}

class GestureDetectorDemo extends StatefulWidget {
  @override
  _GestureDetectorDemoState createState() => new _GestureDetectorDemoState();
}

class _GestureDetectorDemoState extends State<GestureDetectorDemo> {
  String _operation = "No Gesture detected!"; //保存事件名

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("手势识别GestureDetector"),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Text("手势检查 单击 双击 长按"),
                GestureDetector(
                  child: Container(
                    color: Colors.blue,
                    width: 200.0,
                    height: 100.0,
                    alignment: Alignment.center,
                    child: Text(
                      _operation,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () => updateText("tap 单击"),
                  onDoubleTap: () => updateText("DoubleTap 双击"),
                  onLongPress: () => updateText("longpress 长按"),
                ),
                OutlineButton(
                  child: Text(
                    "GestureDetector拖动、滑动",
                    style: TextStyleMs.black_28,
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GestureDetectorDragDemo()));
                  },
                ),
              ],
            ),
          ))),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置相对于屏幕(而非父widget)原点(左上角)的偏移。
    DragUpdateDetails.delta：当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。
    DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，
    常见的效果是根据用户抬起手指时的速度做一个减速动画。
 */
class GestureDetectorDragDemo extends StatefulWidget {
  @override
  _GestureDetectorDragDemoState createState() =>
      new _GestureDetectorDragDemoState();
}

class _GestureDetectorDragDemoState extends State<GestureDetectorDragDemo> {
  double _top = 180.0; //距顶部的偏移
  double _left = 180.0; //距左边的偏移
  String panDown = "";
  String panUpdate = "";
  String panEnd = "";
  int type = 1;
  double _width = 200.0; //通过修改图片宽度来达到缩放效果
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GestureDetector拖动、滑动"),
          centerTitle: true,
        ),
        body: chooseType(3));
  }

  Widget chooseType(int type) {
    if (type == 1) {
      return Stack(
        children: <Widget>[
          Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text("按钮"),
                      Text(panDown),
                      Text(panUpdate),
                      Text(panEnd),
                    ],
                  ),
                ),
                onPanDown: (DragDownDetails ds) {
                  //打印手指按下的位置(相对于屏幕)
                  print("用户手指按下：${ds.globalPosition}");
                  setState(() {
                    panDown = "用户手指按下：${ds.globalPosition}";
                  });
                },
                onPanUpdate: (DragUpdateDetails du) {
                  //用户手指滑动时，更新偏移，重新构建
                  setState(() {
                    _left += du.delta.dx;
                    _top += du.delta.dy;
                    panUpdate = "left = ${_left}\ntop =${_top}";
                  });
                },
                onPanEnd: (DragEndDetails de) {
                  //打印滑动结束时在x、y轴上的速度
                  print(de.velocity);
                  setState(() {
                    panEnd = "打印滑动结束时在x、y轴上的速度${de.velocity}";
                  });
                },
              ))
        ],
      );
    } else if (type == 2) {
      //单一方向拖动
      return Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("单向"),
              ),
              onVerticalDragUpdate: (DragUpdateDetails du) {
                setState(() {
                  _top += du.delta.dy;
                });
              },
            ),
          )
        ],
      );
    } else {
      //监听 缩放
      return Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          child: Container(
            color: Colors.red,
            height: 200.0,
            width: _width,
            alignment: Alignment.center,
            child: Text(
              "宽度缩放",
              style: TextStyle(color: Colors.white),
            ),
          ),
          onScaleUpdate: (ScaleUpdateDetails sd) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 200 * sd.scale.clamp(0.8, 10.0);
            });
          },
        ),
      );
    }
  }
}

class GestureRecognizerDemo extends StatefulWidget {
  @override
  _GestureRecognizerDemoState createState() =>
      new _GestureRecognizerDemoState();
}

class _GestureRecognizerDemoState extends State<GestureRecognizerDemo> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("GestureRecognizer"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，"
                "而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势"),
            Padding(padding: EdgeInsets.all(10.0)),
            Text("假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，但是TextSpan并不是一个Widget，"
                "这时我们不能用GestureDetector，但TextSpan有一个recognizer属性，"
                "它可以接收一个GestureRecognizer，假设我们在点击时给文本变色:"),
            Padding(padding: EdgeInsets.all(30.0)),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "我不可以点击", style: TextStyle(color: Colors.tealAccent)),
              TextSpan(
                  text: "我可以点击",
                  style: TextStyle(
                      color: _toggle ? Colors.blue : Colors.red,
                      fontSize: 18.0),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    }),
              TextSpan(
                  text: "我不可以点击", style: TextStyle(color: Colors.tealAccent)),
            ]))
          ],
        ),
      ),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * 我们发现没有打印"up"，这是因为在拖动时，
 * 刚开始按下手指时在没有移动时，拖动手势还没有完整的语义，
 * 此时TapDown手势胜出(win)，此时打印"down"，而拖动时，拖动手势会胜出，当手指抬起时，
 * onHorizontalDragEnd 和 onTapUp发生了冲突，
 * 但是因为是在拖动的语义中，所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。
 */
class GestureConflictDemo extends StatefulWidget {
  @override
  _GestureConflictDemoState createState() => new _GestureConflictDemoState();
}

class _GestureConflictDemoState extends State<GestureConflictDemo> {
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("手势竞争和冲突"),
      ),
      body: Stack(
        children: <Widget>[
//          Positioned(
//            left: _left,
//            child: GestureDetector(
//              child: CircleAvatar(child: Text("A")), //要拖动和点击的widget
//              onHorizontalDragUpdate: (DragUpdateDetails details) {
//                setState(() {
//                  _left += details.delta.dx;
//                });
//              },
//              onHorizontalDragEnd: (details) {
//                print("onHorizontalDragEnd");
//              },
//              onTapDown: (details) {
//                print("down");
//              },
//              onTapUp: (details) {
//                print("up");
//              },
//            ),
//          )
          //如果我们的代码逻辑中，对于手指按下和抬起是强依赖的，
          // 比如在一个轮播图组件中，我们希望手指按下时，暂停轮播，
          // 而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动手势（支持手动滑动切换）
          // ，甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。
          // 这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行
          Positioned(
            top: 80.0,
            left: _leftB,
            child: Listener(
              onPointerDown: (details) {
                print("down");
              },
              onPointerUp: (details) {
                //会触发
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("B")),
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _leftB += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
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
 * 自定义通知
 */
class NotificationDome extends StatefulWidget {
  @override
  _NotificationDomeState createState() => new _NotificationDomeState();
}

class _NotificationDomeState extends State<NotificationDome> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("自定义通知"),
          centerTitle: true,
        ),
        body: NotificationListener<MyNotification>(
          onNotification: (notification) {
            _msg = notification.msg;
          },
          child: Center(
            child: Column(
              children: <Widget>[
                Builder(
                  //context是根Context，而NotificationListener是监听的子树，
                  // 所以我们通过Builder来构建RaisedButton，来获得按钮位置的context。
                  builder: (context) {
                    return RaisedButton(
                      //按钮点击时分发通知
                      onPressed: () => MyNotification("Hi").dispatch(context),
                      child: Text("Send Notification"),
                    );
                  },
                ),
                Text(_msg)
              ],
            ),
          ),
        ));
  }
}

class MyNotification extends Notification {
  String msg;

  MyNotification(this.msg);
}
