import 'dart:async';
import 'dart:io';

import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergitlabbug/constant.dart';
import 'package:fluttergitlabbug/gitlab_issue_entry.dart';
import 'package:screenshot/screenshot.dart';


class GitLabBug extends StatelessWidget {

  Widget child;

  GitLabBug({this.child});

  ScreenshotController _screenshotController = ScreenshotController();

  _onFabClick(BuildContext context) async {
    File capturedImage = await _screenshotController.capture();

    Navigator.push(context, MaterialPageRoute(builder: (context) => GitLabIssueEntryPage(file: capturedImage,)));
    print(capturedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        Screenshot(
          controller: _screenshotController,
          child: child
        ),

        DraggableFloatingActionButton(
              data: 'Gitlab Tracker',
              offset: new Offset(MediaQuery.of(context).size.width - 70, 60),
              backgroundColor: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(Images.gitlab, package: 'fluttergitlabbug',),
              ),
              onPressed: () => _onFabClick(context),
              appContext: context,
          ),


        ]
      ),
    );
  }

}
