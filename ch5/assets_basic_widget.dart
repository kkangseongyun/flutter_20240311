import 'package:flutter/material.dart';
import 'dart:convert';//json parsing...
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetsBasicWidget extends StatelessWidget {

  Widget makeTextAssetWidget(context){
    //비동기..
    //dart - isolate (thread) - isolate 실행시 사용하는 메모리는 외부에서 접근 불가..
    //rxdart
    //미래에 발생하는 데이터.. Future, Future의 데이터를 활용해서 화면을 구성하기 위한 위젯
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/my_text.txt'),
        //위에 지정한 future 의 데이터 발생을 감지하다가 데이터 발생이 되면 아래의 함수 자동 호출
        //snpashot 에 발생한 실제 데이터 전달..
        builder: (context, snapshot){
          //리턴시키는 위젯이 이 FutureBuilder 의 화면
          if(snapshot.hasData){
            return Text(
              'text asset file : ${snapshot.data}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.red,
                fontSize: 20,
                backgroundColor: Colors.yellow,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,
              ),
              maxLines: 2,
              overflow: TextOverflow.fade,
            );
          }
          return Text("");//최초에도 호출이 되어서.. 빙빙빙.. 혹은 빈 문자열..
        }
    );
  }

  Widget makeJsonAssetWidget(context){
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/data.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            //json 파싱해서..
            var root = json.decode(snapshot.data.toString());
            return Text('json data : ${root[0]['name']}');
          }
          return Text("");
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/icon/user.png'),
        makeTextAssetWidget(context),
        makeJsonAssetWidget(context),
        Icon(Icons.menu),
        Icon(FontAwesomeIcons.music, size: 30, color: Colors.pink,)

      ],
    );
  }
}