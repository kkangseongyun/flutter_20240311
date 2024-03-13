import 'package:flutter/material.dart';
import 'widgets/header_widget.dart';
import 'widgets/image_widget.dart';
import 'widgets/icon_widget.dart';
import 'widgets/content_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        //flutter화면이 출력이 되다가.. 세로, 가로방향으로 화면을
        //벗어나면 자동으로 경고표시(스크롤 준비하지 않았어.. 의미)
        //SingleChildScrollView(하나를 추가.. 그 하나가 스크롤)
        // 혹은 ListView(여러개 추가.. 여러개를 같이 스크롤) 를 이용해서 스크롤 되게 처리해야
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              ImageWidget(),
              IconWidget(),
              ContentWidget(),
            ],
          ),
        )
      ),
    );
  }
}

