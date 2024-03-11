main() {
  //dart 의 모든 변수는 객체이다...
  int data1 = 10;
  print(data1.isEven);

  // double data2 = data1;//error...객체다. int -> double casting 불가하다..
  double data2 = data1.toDouble();
  int data3 = 10.0.toInt();

  //string <-> int
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var...타입유추, 변수 선언과 동시에 대입되는 값에 의해 타입이 고정된다..
  var a = 10;
  // a = "hello";//error
  //dynamic 은 any 타입이다.. 즉 모든 타입의 데이터가 대입되는 타입이다..
  dynamic b = 10;
  b = 'hello';
  //var 로 선언하면서 초기값을 지정하지 않게 되면.. dynamic 으로 유추된다..
  var c;
  c = 10;
  c = 'hello';

  //dart 에서는 List 가 배열이고.. 배열이 List 이다..
  //사이즈 지정하지 않고 사용할때....
  List list1 = [10, 20, 30];
  list1.add(40);
  list1[0] = 50;

  //사이즈,를 지정하고 사용할 때...
  //filled 라는 생성자를 이용해서 객체 생성..
  List list2 = List.filled(3, null);
  list2[0] = 'hello';
  // list2.add('world');//runtime error...

  //map......
  Map map1 = {1:10, 'one':'hello'};
  map1['one'] = 'world';
}