import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//머티리얼 디자인에 입각한 화면 적용..
      home: Scaffold(//화면 기본 구조.. 제공..
        appBar: AppBar(
          title: Text('Widget Test'),
        ),
        body: Center(
          child: Column(
            children: [
              MyStatelessWidget(),
              MyStateWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  //stateless 이지만 얼마든지.. 변수, 함수 선언 가능..
  bool favorited = false;
  int favoriteCount = 10;
  //이벤트 콜백함수..
  void toggleFavorite() {
    print('stateless... toggleFavorite');
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('stateless... build');
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red,
        ),
        Container(
          child: Text('$favoriteCount'),
        ),
      ],
    );
  }
}

class MyStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
class MyState extends State<MyStateWidget> {
  bool favorited = false;
  int favoriteCount = 10;
  //이벤트 콜백함수..
  void toggleFavorite() {
    print('state... toggleFavorite');
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('state... build');
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.red,
        ),
        Container(
          child: Text('$favoriteCount'),
        ),
      ],
    );
  }
}