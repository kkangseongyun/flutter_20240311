import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //서버에서 획득한 데이터..
  List datas = [];

  //Listview 에 지정.. 유저가 스크롤할때.. 이벤트, 스크롤 정보 자동 저장..
  //유저 스크롤 정보를 활용해서.. 페이징 개념..
  ScrollController controller = ScrollController();

  //서버에 전달하는 데이터.. 페이징 처리를 위해서..
  int page = 1;
  int seed = 1;

  Future<List<dynamic>> dioTest() async {
    try {
      var dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
          }
        )
      );

      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20'
      );
      return response.data['results'];
    }catch(e){
      print(e);
    }
    return [];
  }

  //스크롤 이벤트 콜백..
  _scrollListener() async {
    if(controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange){
      //마지막까지 스크롤이 발생한 경우..
      //페이지 번호 증가시켜서 그 다음 페이지 데이터 요청..
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  //초기 서버 데이터 획득..
  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    //초기 데이터 획득..
    dioTest().then((value) {
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //listview refresh 이벤트 콜백..
  Future<void> _refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                        Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}
