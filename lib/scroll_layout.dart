import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/text_style_m.dart';

class ScrollViewDemo extends StatefulWidget {
  @override
  _ScrollViewDemoState createState() => new _ScrollViewDemoState();
}

class _ScrollViewDemoState extends State<ScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ScrollViewWidget"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                OutlineButton(
                  child: Text(
                    "SingleChildScrollView",
                    style: TextStyleMs.black_28,
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleChildScrollViewDemo()));
                  },
                ),
                Text("ListView GridView 不在这里描述"),
                OutlineButton(
                  child: Text(
                    "CustomScrollView",
                    style: TextStyleMs.black_28,
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomScrollViewDemo()));
                  },
                ),
                OutlineButton(
                  child: Text(
                    "ScrollController",
                    style: TextStyleMs.black_28,
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScrollControllerDemo()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class SingleChildScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return new Scaffold(
        appBar: AppBar(
          title: Text("ScrollViewWidget"),
          centerTitle: true,
        ),
        body: Scrollbar(
            //带滚动条
            child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str
                  .split("")
                  //每一个字母都用一个Text显示,字体为原来的两倍
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        )));
  }
}

// ignore: slash_for_doc_comments
/**
 * Sliver有细片、小片之意，在Flutter中，Sliver通常指具有特定滚动效果的可滚动块。
 * 可滚动widget，如ListView、GridView等都有对应的Sliver实现如SliverList、SliverGrid等。
 * 对于大多数Sliver来说，它们和可滚动Widget最主要的区别是Sliver不会包含Scrollable Widget，
 * 也就是说Sliver本身不包含滚动交互模型 ，正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，
 * 这些Sliver共用CustomScrollView的Scrollable，最终实现统一的滑动效果
 */
class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SliverAppBar'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 30 //50个列表项
                ),
          ),
        ],
      ),
    );
  }
}

class ScrollControllerDemo extends StatefulWidget {
  @override
  _ScrollControllerDemoState createState() => new _ScrollControllerDemoState();
}

class _ScrollControllerDemoState extends State<ScrollControllerDemo> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(
                  child: Text("$index"),
                ),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
