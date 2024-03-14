import 'package:flutter/material.dart';
import 'four_screen.dart';
import 'one_screen.dart';
import 'three_screen.dart';
import 'two_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {
        '/one': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
      },
      //라우팅 요청이 발생했을때 실행시켜야 하는 알고리즘, 그 알고리즘에 의해 화면전환이 되어야 한다면..
      //매개변수에 요청한 라우팅 정보가 모두 포함된다.. 라우팅 이름 및 전달하는 데이터..
      onGenerateRoute: (settings){
        if(settings.name == '/three'){
          //알고리즘 돌리고.. 그 결과에 맞는 라우팅을, 혹은 알고리즘에 의해 발생한 데이터를 추가해서..
          //라우팅 정보를 만들어서 리턴시키면 그 정보대로 화면 전환..
          return MaterialPageRoute(
              builder: (context) => ThreeScreen(),
              settings: settings
          );
        }else if(settings.name == '/four'){
          return MaterialPageRoute(
              builder: (context) => FourScreen(),
              settings: settings
          );
        }
      },
    );
  }
}