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
        future: future,
        builder: builder
    );
  }
}