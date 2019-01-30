import 'package:flutter/material.dart';

class AnimationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("动画"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("动画 Animation Curve Tween"),
            OutlineButton(
                child: Text("Animation Curve Tween介绍"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimationCurveTweenDemo()));
                }),
            OutlineButton(
                child: Text("Animation 动画基本结构"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScaleAnimationRoute()));
                }),
          ],
        ),
      ),
    );
  }
}

class AnimationCurveTweenDemo extends StatefulWidget {
  @override
  _AnimationCurveTweenDemoState createState() =>
      new _AnimationCurveTweenDemoState();
}

class _AnimationCurveTweenDemoState extends State<AnimationCurveTweenDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("简介"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
              "Animation是抽象类 AnimationController用于控制动画 Curve类似插值器 Tween 可以用来设置范围的值和数据类型",
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "Animation对象本身和UI渲染没有任何关系。Animation是一个抽象类，它用于保存动画的插值和状态；其中一个比较常用的Animation类是Animation。"),
            Padding(padding: EdgeInsets.all(10.0)),
            Text("我们可以通过Animation来监听动画的帧和状态变化："
                "addListener()可以给Animation添加帧监听器，在每一帧都会被调用。"
                "帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建。addStatusListener()可以给Animation添加“动画状态改变”监听器；"
                "动画开始、结束、正向或反向（见AnimationStatus定义）时会调用StatusListener。"),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "Curve 动画过程可以是匀速的、加速的或者先加速后减速等。Flutter中通过Curve（曲线）来描述动画过程，CurvedAnimation可以通过包装AnimationController和Curve生成一个新的动画对象 。"),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "AnimationController用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法。"),
            //final AnimationController controller = new AnimationController(
            // duration: const Duration(milliseconds: 2000),
            //lowerBound: 10.0,
            //upperBound: 20.0,
            //vsync: this
            // );
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "Tween  默认情况下，AnimationController对象值的范围是0.0到1.0。如果我们需要不同的范围或不同的数据类型，则可以使用Tween来配置动画以生成不同的范围或数据类型的值。"),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);"),
            //以下示例构建了一个控制器、一条曲线和一个Tween：
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
                "final AnimationController controller = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this);final Animation curve =new CurvedAnimation(parent: controller, curve: Curves.easeOut);Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(curve);"),
            Padding(padding: EdgeInsets.all(30.0)),
          ],
        ),
      )),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("3种动画结构方式"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
                child: Text("基本的构造方式"),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ScaleAnimationBaseDemo()));
                }),
            OutlineButton(
                child: Text("AnimatedWidget方式"),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => AnimatedWidgetDemo()));
                }),
            OutlineButton(
                child: Text("AnimatedBuilder方式"),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => AnimatedBuilderDemo()));
                }),
          ],
        ),
      ),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * 上面代码中addListener()函数调用了setState()，所以每次动画生成一个新的数字时，
 * 当前帧被标记为脏(dirty)，这会导致widget的build()方法再次被调用，而在build()中，
 * 改变Image的宽高，因为它的高度和宽度现在使用的是animation.value ，所以就会逐渐放大。
 * 值得注意的是动画完成时要释放控制器(调用dispose()方法)以防止内存泄漏。
 *
 * 整个build下都会重新构建 影响性能
 *
 */
class ScaleAnimationBaseDemo extends StatefulWidget {
  @override
  _ScaleAnimationBaseDemoState createState() =>
      new _ScaleAnimationBaseDemoState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationBaseDemoState extends State<ScaleAnimationBaseDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("基本的构造方式"),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        color: Colors.orange,
        width: animation.value,
        height: animation.value,
      )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

// ignore: slash_for_doc_comments
/**
 *
 * AnimatedWidget 控件内更新 局部更新 降低喧嚷 封装性好
 */
class AnimatedWidgetDemo extends StatefulWidget {
  @override
  _AnimatedWidgetDemoState createState() => new _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<AnimatedWidgetDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {})
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("AnimatedWidget方式"),
        centerTitle: true,
      ),
      body: AnimateContainerDemo(
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

class AnimateContainerDemo extends AnimatedWidget {
  AnimateContainerDemo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // TODO: implement build
    return Center(
        child: Container(
      color: Colors.orange,
      width: animation.value,
      height: animation.value,
    ));
  }
}

// ignore: slash_for_doc_comments
/**
 * 不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。

    动画构建的范围缩小了，如果没有builder，setState()将会在父widget上下文调用，这将会导致父widget的build方法重新调用，而有了builder之后，只会导致动画widget的build重新调用，这在复杂布局下性能会提高。

    通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
 */
class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => new _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {})
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });
    //启动动画(正向执行)
    controller.forward();
  }

//  @override
//  Widget build(BuildContext context) {
//    return new AnimatedBuilder(
//        animation: animation,
//        builder: (BuildContext context, Widget child) {
//          return Center(
//              child: Container(
//                color: Colors.orange,
//                width: animation.value,
//                height: animation.value,
//              ));
//        });
//    // ignore: slash_for_doc_comments
//    /**
//     * 上面的代码中有一个迷惑的问题是，
//     * child看起来像被指定了两次。但实际发生的事情是：
//     * 将外部引用child传递给AnimatedBuilder后AnimatedBuilder再将其传递给匿名构造器，
//     * 然后将该对象用作其子对象。最终的结果是AnimatedBuilder返回的对象插入到Widget树中。
//     */
//  }

  // ignore: slash_for_doc_comments
  /**
   * dismissed	动画在起始点停止
      forward	动画正在正向执行
      reverse	动画正在反向执行
      completed	动画在终点停止
   */
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("AnimatedBuilder方式"),
        centerTitle: true,
      ),
      body: GrowTransition(
        child: Container(
          color: Colors.orange,
          width: animation.value,
          height: animation.value,
        ),
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

// ignore: slash_for_doc_comments
/**
 *封装常见的过渡效果来复用动画
 */
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}
