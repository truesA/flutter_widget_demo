import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/text_style_m.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => new _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  TextEditingController _controllerName = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controllerName.text = "hello"; //controller 提前设置默认值
    //设置文字选中
    _controllerName.selection =
        TextSelection(baseOffset: 2, extentOffset: _controllerName.text.length);

    //通过controller监听   可以进行字符判断
    _controllerName.addListener(() {
      print(_controllerName.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("TextFieldDemo"),
        centerTitle: true,
      ),
      body: new Container(
//        decoration: BoxDecoration(
//          border: Border(
//              bottom: BorderSide(
//                  color: Colors.grey[200], width: 1.0)), // 下滑线浅灰色，宽度1像素
//        ),
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: "内容说明",
                      labelStyle: TextStyleMs.ff_3db034_30,
                      helperText: "帮助提示",
                      helperStyle: TextStyleMs.ff_58aff930,
                      hintText: "hint",
                      hintStyle: TextStyleMs.ff_ffbe1f_28),
                ),
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    //隐藏下划线
                    filled: true,
                    fillColor: Colors.white,
                    counterText: "1111",
                    suffixText: "2222",
                    suffixIcon: Icon(Icons.arrow_upward),
                    contentPadding: EdgeInsets.only(top: 15.0),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                Text("controller监听"),
                TextField(
                  controller: _controllerName,
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow,
                    helperText: "输出数字",
                    errorMaxLines: 5,
                    errorText: "输出错误",
//                  errorBorder: OutlineInputBorder(
//                    gapPadding: 5.0,
//                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//                  ),
                    disabledBorder: UnderlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    enabledBorder: OutlineInputBorder(
                        gapPadding: 5.0,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                  ),
                ),
                OutlineButton(
                  child: Text("控制焦点 FocusNode"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => FocusTestRoute()));
                  },
                ),
                OutlineButton(
                  child: Text("From 表单提交 适合于登录"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => FromTextFieldDemo()));
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //焦点监听 获得焦点时focusNode.hasFocus值为true，失去焦点时为false。
    focusNode2.addListener(() {
      print(focusNode2.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("控制焦点"),
        centerTitle: true,
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              focusNode: focusNode1,
              autofocus: true,
              decoration: InputDecoration(labelText: "input1"),
            ),
            TextField(
              focusNode: focusNode2,
              decoration: InputDecoration(labelText: "input2"),
            ),
            RaisedButton(
              child: Text("移动焦点"),
              onPressed: () {
                //将焦点从第一个TextField移到第二个TextField
                // 这是一种写法  FocusScope.of(context).requestFocus(focusNode2);
                // 这是第二种写法
//
                if (null == focusScopeNode) {
                  focusScopeNode = FocusScope.of(context);
                }
                focusScopeNode.requestFocus(focusNode2);
              },
            ),
            RaisedButton(
              child: Text("隐藏键盘"),
              onPressed: () {
                // 当所有编辑框都失去焦点时键盘就会收起
                focusNode1.unfocus();
                focusNode2.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Form({
    @required Widget child,
    bool autovalidate = false,
    WillPopCallback onWillPop,
    VoidCallback onChanged,
    })
    autovalidate：是否自动校验输入内容；当为true时，每一个子FormField内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。
    onWillPop：决定Form所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个Future对象，如果Future的最终结果是false，则当前路由不会返回；如果为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。
    onChanged：Form的任意一个子FormField内容发生变化时会触发此回调


    const FormField({
    ...
    FormFieldSetter<T> onSaved, //保存回调
    FormFieldValidator<T>  validator, //验证回调
    T initialValue, //初始值
    bool autovalidate = false, //是否自动校验。
    })


    FormState
    FormState为Form的State类，可以通过Form.of()或GlobalKey获得。我们可以通过它来对Form的子孙FormField进行统一操作。我们看看其常用的三个方法：

    FormState.validate()：调用此方法后，会调用Form子孙FormField的validate回调，如果有一个校验失败，则返回false，所有校验失败项都会返回用户返回的错误提示。
    FormState.save()：调用此方法后，会调用Form子孙FormField的save回调，用于保存表单内容
    FormState.reset()：调用此方法后，会将子孙FormField的内容清空。
 */
class FromTextFieldDemo extends StatefulWidget {
  @override
  _FromTextFieldDemoState createState() => new _FromTextFieldDemoState();
}

class _FromTextFieldDemoState extends State<FromTextFieldDemo> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("FromTextFieldDemo"),
          centerTitle: true,
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidate: false,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
//                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  },
                ),
                Padding(padding: EdgeInsets.all(20.0)),
                TextFormField(
                    autofocus: false,
                    controller: _pwdController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
//                        labelText: "密码",
                        hintText: "您的登录密码",
                        icon: Icon(Icons.lock)),
                    obscureText: true,
                    //校验密码
                    validator: (v) {
                      return v.trim().length > 5 ? null : "密码不能少于6位";
                    }),
                // 登录按钮
                Padding(padding: EdgeInsets.all(20.0)),
                Builder(builder: (context) {
                  return Container(
                    width: 300.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      )),
                      padding: EdgeInsets.all(15.0),
                      child: Text("登录"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        //在这里不能通过此方式获取FormState，context不对
                        //print(Form.of(context));

                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        if ((_formKey.currentState as FormState).validate()) {
                          //验证通过提交数据
                          print("验证通过提交数据");
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text("成功")));
                        }
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
