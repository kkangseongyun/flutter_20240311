//typedef - custom type 선언..
//자주 사용하는 함수 타입이 복잡하다면.. 하나의 타입을 선언해서 사용할 수도..
typedef MyFunctionType<T, A> = T Function(A arg);

main() {
  //named optional.....................
  void function1(bool data1, {String? data2, int data3 = 0}){

  }
  function1(true);
  // function1(true, "hello", 10);//error
  function1(true, data2: "hello");
  function1(true, data3: 10);
  function1(true, data3: 20, data2: "world");//named parameter, 순서는 의미가 없다.


  //positional parameter.........
  void function2(bool data1, [String? data2, int data3 = 0]){}
  function2(true);
  // function2(true, data2:"hello", data3:10);//error.. 이름 명시할 수 없다..
  // function2(true, 10, "hello");//순서 위배할 수 없다..
  function2(true, "hello");
  function2(true, "hello", 10);

  //high order function(고차함수. 함수를 다른 함수의 매개변수로, 리턴값으로..)
  int some(int no){ return no * 10; }

  void f1(Function argFun){}
  //아무 함수나..
  f1(some);

  //함수 타입을 한정짓고 싶다면...
  void f2(int Function(int a) argFun){}
  f2(some);

  void f3(MyFunctionType<int, int> argFun){}
  f3(some);
}