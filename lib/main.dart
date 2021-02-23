import 'package:flutter/material.dart';
import 'package:my_flutter_components/components/select/index.dart';
import 'package:my_flutter_components/components/select/select-item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List options = [
    {'value': '选项1', 'label': '黄金糕'},
    {'value': '选项2', 'label': '双皮奶'},
    {'value': '选项3', 'label': '蚵仔煎'},
    {'value': '选项4', 'label': '龙须面'},
    {'value': '选项5', 'label': '北京烤鸭'},
  ];
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('组件'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            QlSelect(
              children: [
                ...List.generate(
                  options.length,
                      (index) => QlSelectItem(
                    label: options[index]['label'],
                    value: options[index]['value'],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
