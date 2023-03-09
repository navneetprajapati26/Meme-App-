import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Btn extends StatelessWidget {

  String btnName;
  Function() onPressed;

  Btn({Key? key, required this.onPressed,required this.btnName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Color(0x79FFD64F),
              border: Border.all(color: Colors.amber, width: 3),
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(btnName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ));
  }
}
