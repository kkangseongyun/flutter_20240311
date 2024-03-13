import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//이벤트 내용. VO 클래스..
class DataVO {
  String image;
  String title;
  String date;
  String content;
  String location;
  DataVO(this.image, this.title, this.date, this.content, this.location);
}

List<DataVO> datas = [
  DataVO('images/lab_lotte_1.jpg', '롯데웨딩위크', '각 지점 본 매장', '2.14(금) ~ 2.23(일)',
      '백화점 전점'),
  DataVO('images/lab_lotte_2.jpg', 'LG TROMM 스타일러', '각 지점 본 매장',
      '2.14(금) ~ 2.29(토)', '백화점 전점'),
  DataVO(
      'images/lab_lotte_3.jpg', '금양와인 페스티발', '본매장', '2.15(토) ~ 2.20(목)', '잠실점'),
  DataVO('images/lab_lotte_4.jpg', '써스데이 아일랜드', '본 매장', '2.17(월) ~ 2.23(일)',
      '잠실점'),
  DataVO('images/lab_lotte_5.jpg', '듀풍클래식', '본 매장', '2.21(금) ~ 3.8(일)', '잠실점'),
];

//각 이벤트 하나를 추상화시킨 위젯.. 이벤트 갯수 만큼 반복 생성..
class CardADWidget extends StatelessWidget {
  DataVO vo;
  CardADWidget(this.vo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.pink,),
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(vo.image, width: 350,),
                  Container(
                    width: 350,
                    height: 100,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vo.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text(vo.content),
                        Text(vo.date),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: 30,
                  bottom: 90,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black,
                    child: Text(vo.location, style: TextStyle(color: Colors.white),),
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//PageView 에 의해 화면 출력.. stateful 로..
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  //데이터 갯수 만큼.. card 위젯 생성하는 함수..
  List<CardADWidget> makeWidgets() {
    return datas.map((vo) {
      return CardADWidget(vo);
    }).toList();
  }

  //PageView. 손가락 따라서 좌우로.. 그 제어자..
  PageController controller = PageController(
    initialPage: 0,
    //1.0 미만의 숫자로 지정.. 현재 화면 좌, 우에 내용이 현재 화면에서 어느정도 보여야 하는지?
    //1.0이면 현재 화면만 보이고.. 작게 지정할 수록 좌우내용이 더 많이 보이고..
    viewportFraction: 0.9,
  );
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView(
              children: makeWidgets(),
              controller: controller,
            )
        ),
        SmoothPageIndicator(
            controller: controller,
            count: 6,
            effect: WormEffect(
              dotColor: Colors.white,
              activeDotColor: Colors.indigo
            ),
            onDotClicked: (index){},//추가 이벤트 처리도 가능하다..
        ),
        SizedBox(height: 32.0,)
      ],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body:Container(
          color: Colors.pink,
          child: MyWidget(),
        )
      ),
    );
  }
}

