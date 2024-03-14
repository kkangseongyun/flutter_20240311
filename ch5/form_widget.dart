import 'package:flutter/material.dart';

//유저 입력 데이터 저장 VO
class UserVO {
  String? firstName = '';
  String? lastName = '';
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormWidgetState();
  }
}

class FormWidgetState extends State<FormWidget> {
  //Form 위젯에 지정할 key, 나중에 이 키로.. Form 의 State 객체 획득해서 작업 명령..
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserVO user = UserVO();

  //유저 입력이 끝난 후에.. 호출되는 개발자 함수..
  save() {
    print('save... ${user.firstName}, ${user.lastName}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Form 과 연동이 되어야 해서.. TextField 가 아닌.. TextFormField
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              //Form 의 State 에 있는 validate() 호출시에 자동 호출..
              //매개변수는 유저 입력 데이터..
              validator: (value){
                if(value?.isEmpty ?? false){
                  return 'please enter your first name';//invalid message
                }
                return null;//valid
              },
              onSaved: (value) => setState(() {
                user.firstName = value;
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value){
                if(value?.isEmpty ?? false){
                  return 'please enter your last name';//invalid message
                }
                return null;//valid
              },
              onSaved: (value) => setState(() {
                user.lastName = value;
              }),
            ),
            ElevatedButton(
                onPressed: (){
                  //form 의 state 객체 획득
                  final form = formKey.currentState;
                  //모든 field 의 validator() 호출.. 모두 null 을 리턴한 경우에 true
                  if(form?.validate() ?? false){
                    form?.save();//모든 field 의 onSave 함수 호출..
                    save();
                  }
                },
                child: Text('save'),
            ),
          ],
        )
    );
  }
}