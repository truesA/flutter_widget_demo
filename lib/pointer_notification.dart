import 'package:flutter/material.dart';

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
            )));
  }
}
