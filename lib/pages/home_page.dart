import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeCotroller = TextEditingController();
  String showText = '欢迎您来到美好人间高级会所';

  Future getHttp(String text) async {
    const url =
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian";
    try {
      var data = {'name': text};
      Response res = await Dio().get(url, queryParameters: data);
      // Response res = await Dio().post(url, queryParameters: data);
      return res.data;
    } catch (e) {
      return print(e);
    }
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型...............');
    if (typeCotroller.text.toString() == '') {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(title: Text("美女不能为空")));
    } else {
      getHttp(typeCotroller.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间')),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: typeCotroller,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: '美女类型',
                      helperText: "请输入你喜欢的类型"),
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('选择完毕'),
                ),
                Text(showText, overflow: TextOverflow.ellipsis, maxLines: 1)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text('商城首页')),
//     );
//   }
//
//   void getHttp() async {
//      try {
//        Response res = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女");
//        return print(res);
//      }catch(e) {
//        return print(e);
//      }
//   }
// }
