import 'package:flutter/material.dart';

class ButtonComponent {
  static Widget buttonComponent(
    BuildContext context,
    String buttonTitle,
    Widget buttonIcon,
    VoidCallback? onclick
  ) {
    return ElevatedButton(
      onPressed: () {
        if(onclick != null){
          onclick();
        }
      } ,
      child: Container(
        height: 50,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonIcon,
            SizedBox(width: 5),
            Text(
              buttonTitle,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 223, 129, 129),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(35),
        )
      ),
    );
  }
}
