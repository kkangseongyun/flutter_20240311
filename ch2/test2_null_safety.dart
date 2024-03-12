int data1 = 10;
int? data2;

main() {
  // data1 = null;//error
  data2 = 10;
  data2 = null;

  int? data3 = 10;
  data3!;
  data3 = null;
  data3!;

  data1.isEven;
  data2?.isEven;

  bool? result = data2?.isEven;

  String? data4 = "hello";
  String? result2 = data4 ?? "world";//hello
  data4 = null;
  result2 = data4 ?? "world";//world

  //타입적으로 nullable 이 non-null 의 상위 타입이다..
  int data5 = 10;
  int? data6 = data5;//ok , 암시적 캐스팅..
  // int data7 = data2;//error
  int data7 = data2 as int;//명시적 캐스팅..

}