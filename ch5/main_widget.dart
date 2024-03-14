import 'package:flutter/material.dart';
import 'assets_basic_widget.dart';
import 'form_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedIndex = 0;//tab 선택 index..

  List<Widget> widgets = <Widget>[
    AssetsBasicWidget(),
    FormWidget(),
  ];

  //tab 버튼 클릭 이벤트..
  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //물론 우리는 appbar 에 백그라운드 이미지를 올릴거여서.. 이미지만 없다면.. 이 색상으로..
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: Text('AppBar Bottom Title'),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/big.jpeg'),
                fit: BoxFit.fill,
              )
            ),
          ),
          title: Text('Widget Test'),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_alert)),
            IconButton(onPressed: (){}, icon: Icon(Icons.navigate_next)),
          ],
        ),
        body: Center(
          child: widgets.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,//animation 효과, fixed - 변화없고..
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'First',
                backgroundColor: Colors.green,//이 탭 버튼이 선택이 될때.. bar 전체의 칼라..
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Second',
              backgroundColor: Colors.pink,//이 탭 버튼이 선택이 될때.. bar 전체의 칼라..
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Text('Drawer Header'),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(title: Text('Item1'), onTap: () {},),
              ListTile(title: Text('Item2'), onTap: () {},),
            ],
          ),
        ),
      ),
    );
  }
}

