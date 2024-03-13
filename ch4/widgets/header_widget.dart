import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//popup menu 문자열..
const List<String> choices = <String>[
  '신고', '링크 복사', '공유하기'
];

class HeaderWidget extends StatelessWidget {
  //popup menu 클릭 이벤트..
  void select(String choice){
    //toast 띄우기..
    Fluttertoast.showToast(
        msg: choice,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/lab_instagram_icon_0.jpg'),
        Container(//화면의 특정 영역을 지칭해서 다양하게 꾸미기 위한 위젯..
          padding: EdgeInsets.only(left: 16),//all 은 4방향 동일 사이즈.
          child: Text('instagram'),
        ),
        Spacer(),//빈 공간을 차지하는 위젯..
        PopupMenuButton(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              //처음에는 ..., 유저가 ... 을 클릭하면 메뉴가 나열..
              //그 나열되는 메뉴를 어떻게 구성할 것인가?
              return choices.map<PopupMenuItem<String>>((String choice){
                return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                );
              }).toList();
            }
        ),
      ],
    );
  }
}