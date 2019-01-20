import 'dart:math' as math;

import 'package:flutter/material.dart';

class ContainerLayoutDemo extends StatefulWidget {
  @override
  _ContainerLayoutDemoState createState() => new _ContainerLayoutDemoState();
}

class _ContainerLayoutDemoState extends State<ContainerLayoutDemo> {
  @override
  Widget build(BuildContext context) {
    Widget redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
    //ConstrainedBox
    /**
     * const BoxConstraints({
        this.minWidth = 0.0, //最小宽度
        this.maxWidth = double.infinity, //最大宽度
        this.minHeight = 0.0, //最小高度
        this.maxHeight = double.infinity //最大高度
        })
     */
    return new Scaffold(
      appBar: AppBar(
        title: Text("容器widget"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("ConstrainedBox"),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: double.infinity, //宽度尽可能大
                  minHeight: 50.0 //最小高度为50像素
                  ),
              child: Container(
//                color: Colors.red,
                height: 5.0,
                decoration: BoxDecoration(color: Colors.red),
              ),
            ),
            Text("SizedBox"),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: redBox,
            ),
            Text("实际上SizedBox和只是ConstrainedBox一个定制 SizedBox上面代码等价于"),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 80.0, height: 80.0),
              child: redBox,
            ),
            Text("BoxConstraints.tightFor(width: 80.0,height: 80.0) 等价于："
                "BoxConstraints(minHeight: 80.0,maxHeight: 80.0,minWidth: 80.0,maxWidth: 80.0)"),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
                "多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。"),
            OutlineButton(
              child: Text(
                "DecoratedBox",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DecoratedBoxDemo()));
              },
            ),
            Text("Transform变换"),
            OutlineButton(
              child: Text(
                "Transform",
                style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => TransformDemo()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DecoratedBoxDemo extends StatefulWidget {
  @override
  _DecoratedBoxDemoState createState() => new _DecoratedBoxDemoState();
}

// ignore: slash_for_doc_comments
/**
 * const DecoratedBox({
    Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
    Widget child
    })

    decoration：代表将要绘制的装饰，它类型为Decoration，Decoration是一个抽象类，它定义了一个接口 createBoxPainter()，子类的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰。
    position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类两个值：
    background：在子widget之后绘制，即背景装饰。
    foreground：在子widget之上绘制，即前景。
 */
class _DecoratedBoxDemoState extends State<DecoratedBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("DecoratedBox"),
          centerTitle: true,
        ),
        /**
       * BoxDecoration({
          Color color, //颜色
          DecorationImage image,//图片
          BoxBorder border, //边框
          BorderRadiusGeometry borderRadius, //圆角
          List<BoxShadow> boxShadow, //阴影,可以指定多个
          Gradient gradient, //渐变
          BlendMode backgroundBlendMode, //背景混合模式
          BoxShape shape = BoxShape.rectangle, //形状
          })
       */
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print("111");
                },
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.blueGrey[700]]),
                        borderRadius: BorderRadius.circular(3.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 18.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}

class TransformDemo extends StatefulWidget {
  @override
  _TransformDemoState createState() => new _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作"),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Container(
              color: Colors.black,
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.5弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent!'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text("平移"),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              //默认原点为左上角，左移20像素，向上平移5像素
              child: Transform.translate(
                offset: Offset(-29.0, -5.0),
                child: Text("Hello world"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text("旋转"),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Transform.rotate(
                angle: math.pi / 3,
                child: Text("Hello world"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text("缩放"),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                scale: 1.5, //放大到1.5倍
                child: Text("Hello world"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text("RotatedBox"),
            Text(
                "RotatedBox和Transform.rotate功能相似，它们都可以对子widget进行旋转变换，但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子widget的位置和大小。"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/**
 * Container({
    this.alignment,
    this.padding, //容器内补白，属于decoration的装饰范围
    Color color, // 背景色
    Decoration decoration, // 背景装饰
    Decoration foregroundDecoration, //前景装饰
    double width,//容器的宽度
    double height, //容器的高度
    BoxConstraints constraints, //容器大小的限制条件
    this.margin,//容器外补白，不属于decoration的装饰范围
    this.transform, //变换
    this.child,
    })
 */
