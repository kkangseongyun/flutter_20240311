class User {
  String? name;
  int? age;
  //클래스명과 동일한 이름의 생성자..
  User(this.name, this.age);//생성자에 한해서는 실행로직이 없다면 {} 을 생략해도 된다.
  //생성자를 여러개 정의한다면.. 각각의 생성자에 이름을 추가해서..
  User.one(){
    name="kim";
    age=20;
  }
  //다른 생성자 호출은 초기화 영역에...
  User.two(String name, int age):this(name,age);
}

class SingletonClass {
  int? data;
  SingletonClass._privateContructor();//생성자.. 내부에서만 접근할 수 있는 생성자..
  static final SingletonClass _instance = SingletonClass._privateContructor();
  factory SingletonClass() => _instance;
}

main() {
  SingletonClass obj1 = SingletonClass();
  SingletonClass obj2 = SingletonClass();
  obj1.data = 10;
  obj2.data = 20;
  print("${obj1.data}, ${obj2.data}");//20, 20
}

class MyClass {
  int no = 10;
  String name = "kim";
  void sayHello() {}
}
//상속 관계로 클래스 이용..
class SubClass extends MyClass {

}
//클래스를 interface 로...
class InterfaceClass implements MyClass {
  int no = 20;
  String name = "lee";
  @override
  void sayHello() {

  }
}

//mixin...어떤 클래스가 되든.. 공통 멤버가 있다면..
mixin MyMixin {
  int mixinData = 0;
  void mixinFun() {}
}
//클래스에서 믹스인을 사용하려면 with 예약어로...
class MixinClass with MyMixin {
  void some() {
    mixinData = 20;
    mixinFun();
  }
}