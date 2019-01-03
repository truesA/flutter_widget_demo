import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/text_style_m.dart';

// ignore: slash_for_doc_comments
/**
 * const Scaffold({
    Key key,
    this.appBar,//标题栏
    this.body,//内容
    this.floatingActionButton,//悬浮按钮
    this.persistentFooterButtons,底部持久化现实按钮
    this.drawer,//侧滑菜单左
    this.endDrawer,//侧滑菜单右
    this.bottomNavigationBar,//底部导航
    this.backgroundColor,//背景颜色
    this.resizeToAvoidBottomPadding: true,//自动适应底部padding
    this.primary: true,试用使用primary主色
    })


    AppBar({
    Key key,
    this.leading,主导Widget
    this.automaticallyImplyLeading: true,
    this.title,
    this.actions,其他附加最贱右上角
    this.flexibleSpace,//伸缩空间，显示在title上面
    this.bottom,//显示在title下面
    this.elevation: 4.0,//阴影高度
    this.backgroundColor,
    this.brightness,明暗模式
    this.iconTheme,
    this.textTheme,
    this.primary: true,是否是用primary
    this.centerTitle,//标题是否居中
    this.titleSpacing: NavigationToolbar.kMiddleSpacing,//title与leading的间隔
    this.toolbarOpacity: 1.0,//title级文字透明度
    this.bottomOpacity: 1.0,//底部文字透明度
    })


    const FloatingActionButton({
    Key key,
    this.child,
    this.tooltip,//提示，长按按钮提示文字
    this.backgroundColor,//背景颜色
    this.heroTag: const _DefaultHeroTag(),//页面切换动画Tag
    this.elevation: 6.0,//阴影
    this.highlightElevation: 12.0,//高亮阴影
    @required this.onPressed,//点击事件
    this.mini: false//是否使用小图标
    })


    const Drawer({
    Key key,
    this.elevation: 16.0,
    this.child,
    })


    BottomNavigationBar({
    Key key,
    @required this.items,//List<BottomNavigationBarItem>
    this.onTap,//tap事件
    this.currentIndex: 0,//当前位置
    BottomNavigationBarType type,//底部item类型，fixed自适应，shifting选择放大
    this.fixedColor,选中颜色
    this.iconSize: 24.0,//图标大小
    })
 */
class ScaffoldDemo extends StatefulWidget {
  @override
  _ScaffoldDemoState createState() => new _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
//        leading: IconButton(
//          icon: Icon(Icons.account_circle),
//          onPressed: () {},
//        ),
        title: Text("ScaffoldDemo"),
        centerTitle: true,
        elevation: 10.0,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: () {},
          ),
        ],
      ),
      body: new Container(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: new Icon(Icons.arrow_upward),
          onPressed: () {
            Navigator.pop(context);
          }),
      persistentFooterButtons: <Widget>[
        new Icon(Icons.android),
        new Icon(Icons.book),
        new Icon(Icons.hourglass_empty),
        new Icon(Icons.headset),
        new Icon(Icons.home),
        new Icon(Icons.help)
      ],
      drawer: drawerViews(),
//      endDrawer: drawerViews(),
      bottomNavigationBar: bottomNavigationBarView(),
    );
  }

  Widget drawerViews() {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "http://t2.hddhhn.com/uploads/tu/201612/98/st93.png"))),
            accountName: Text("mine"),
            accountEmail: Text("123456@qq.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.refresh),
            title: new Text("刷新"),
          ),
          new ListTile(
            leading: new Icon(Icons.help),
            title: new Text("帮助"),
          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text(
              "会话",
              style: TextStyleMs.black_24,
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text("设置"),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBarView() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_cart), title: new Text("购物车")),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.message), title: new Text("会话")),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.person), title: new Text("我的")),
      ],
      fixedColor: Colors.red,
      currentIndex: index,
      onTap: (valueInt) {
        setState(() {
          index = valueInt;
        });
      },
    );
  }
}
