import 'package:flutter/material.dart';
//상위의 상태 데이터를 하위에 전파 시키는 역할...
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

//앱의 루트 위젯을 stateful 로 만드는 것은 권장할만 하지는 않지만.. 상위 상태 변경에 의해
//하위 상태의 라이프사이클이 어떻게 변경되는지 테스트 하기 위해서 stateful 로..
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}
class ParentState extends State<ParentWidget> {
  //상위에서 유지되고 관리되는 상태 데이터라는 가정.. 이 데이터가 상위에서 변경되고.. 하위에
  //전파될때 하위 state 의 라이프 사이클 변경..
  int count = 0;

  void incrementCount() {
    setState(() {
      count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( title: Text('LifeCycle Test'),),
        body: Provider.value(//자신의 데이터를 하위 위젯에 공개해서 하위 위젯에서 이용하기 위해
            value: count,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('I am parent Widget, $count'),
                  ChildWidget(),
                ],
              ),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: incrementCount,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  //위젯은 불변이다.. stateful 조차도.. 확인하기 위해서..
  ChildWidget() {
    print('ChildWidget... constructor...');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}
//app 전체의 라이프사이클 이벤트 감지하기 위해서..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{
  //상위의 데이터..
  int count = 0;
  ChildState() {
    print("ChildState...constructor...");
  }
  @override
  void initState() {
    print('ChildState... initState...');
    super.initState();
    //초기 상태 값 설정.. 최초에 한번만 걸면 되는 이벤트 등록..
    WidgetsBinding.instance.addObserver(this);//앱 전체 라이프사이클 이벤트 등록..
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    //상위의 상태 데이터 획득..
    count = Provider.of<int>(context);
    print('ChildState...didChangeDependencies, $count');
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    print('ChildState... build..');
    return Text('I am ChildWidget, $count');
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App Lifecycle, $state');
  }
}

//초기 로그
//I/flutter (14834): ChildWidget... constructor...
// I/flutter (14834): ChildState...constructor...
// I/flutter (14834): ChildState... initState...
// I/flutter (14834): ChildState...didChangeDependencies, 0
// I/flutter (14834): ChildState... build..

//상위 상태 변경에 의한 화면 갱신...
//화면이 갱신될때 마다.. 위젯은 매번 생성.. 위젯은 불변..
//I/flutter (14834): ChildWidget... constructor...
// I/flutter (14834): ChildState...didChangeDependencies, 1
// I/flutter (14834): ChildState... build..

//app lifecycle
//I/flutter (14834): App Lifecycle, AppLifecycleState.hidden
// I/flutter (14834): App Lifecycle, AppLifecycleState.paused
// I/flutter (14834): App Lifecycle, AppLifecycleState.hidden
// I/flutter (14834): App Lifecycle, AppLifecycleState.inactive
// E/OpenGLRenderer(14834): Unable to match the desired swap behavior.
// I/flutter (14834): App Lifecycle, AppLifecycleState.resumed