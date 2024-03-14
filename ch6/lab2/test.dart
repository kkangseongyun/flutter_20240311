import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    //add..................................
    return MaterialApp.router(
      routerDelegate: MyRouteDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}
//add...................................
//라우팅시 유지해야 하는 정보를 담는 개발자 클래스..
//필요한 만큼 변수선언, 편의성을 위한 생성자 선언..
class MyRoutePath {
  String? id;
  MyRoutePath.home() : this.id = null;
  MyRoutePath.detail(this.id);
}

//라우팅을 위해 필요한 정보 분석 역할..
//제네릭은 분석된 결과를 담을 수 있는 클래스 타입..
class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  //앱이 실행되면서 가장 먼저 호출..
  @override
  Future<MyRoutePath> parseRouteInformation(RouteInformation routeInformation) async{
    Uri uri = routeInformation.uri;
    if(uri.pathSegments.length >= 2){
      var remaining = uri.pathSegments[1];
      return MyRoutePath.detail(remaining);
    }else {
      return MyRoutePath.home();
    }
  }
}

//실제 라우팅을 처리하는 대행자..
class MyRouteDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  String? selectId;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //자동 호출되는 함수, build  가 호출되어 실제 라우팅이 발생하기 직전에 호출..
  //리턴시키는 값이 parser 에 다시 전달되어.. 이런 정보로 라우팅을 할거야.. 알려줘서.. parser 에서 필요하다면
  //저장해 놓게..
  @override
  MyRoutePath? get currentConfiguration{
    if(selectId != null){
      return MyRoutePath.detail(selectId);
    }else {
      return MyRoutePath.home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        //첫화면을 스택에 먼저 올리고..
        MaterialPage(child: HomeScreen(_handleOnPressed)),
        //id 값이 있다면 .. home 위에 detail 까지 올려서.. 유저 화면에 detail 이 나오게..
        if(selectId != null) MaterialPage(child: DetailScreen(selectId))
      ],
      //back 에 의해 되돌아 올때 호출..
      onPopPage: (route, result){
        if(!route.didPop(result)){
          return false;
        }
        selectId = null;
        notifyListeners();
        return true;
      },
    );
  }
  //HomeScreen 에 매개변수로 전달하는 함수.. 이벤트는 HomeScreen 에서 발생.. 화면제어는 이 delegate
  void _handleOnPressed(String id){
    selectId = id;
    //화면이 갱신되어야 한다.. 갱신 명령..
    notifyListeners();
  }

  //parser 의 parseRouteInformation 함수가 호출된 후에 호출.. parseRouteInformation에서 리턴시킨
  //분석 결과 데이터가 매개변수로 전달..
  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async{
    if(configuration.id != null){
      selectId = configuration.id;
    }
  }
}


class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onPressed;

  HomeScreen(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Screen',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ElevatedButton(
                child: Text('go detail with 1'),
                onPressed: () => onPressed('1'),
              ),
              ElevatedButton(
                child: Text('go detail with 2'),
                onPressed: () => onPressed('2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;

  DetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Detail Screen $id',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
