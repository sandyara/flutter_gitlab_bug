import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  final bool allowPop;

  LoadingWidget({this.message = "", this.allowPop = false});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(allowPop),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  message,
                  style: TextStyle(fontSize: 20),
                )
              ],
            )),
      ),
    );
  }
}
