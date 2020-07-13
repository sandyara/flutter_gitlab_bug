import 'dart:async';
import 'dart:io';

import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gitlab_bug/authentication.dart';
import 'package:flutter_gitlab_bug/constant.dart';
import 'package:flutter_gitlab_bug/gitlab_issue_entry.dart';
import 'package:flutter_gitlab_bug/service/secure_storage.dart';
import 'package:screenshot/screenshot.dart';

class GitLabBug extends StatefulWidget {

  final Widget child;
  final String customDomain;
  final int projectId;

  GitLabBug({@required this.child, @required this.projectId, this.customDomain});

  @override
  _GitLabBugState createState() => _GitLabBugState();
}

class _GitLabBugState extends State<GitLabBug> {
  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  SecureStorage _secureStorage = new SecureStorage();
  ScreenshotController _screenshotController = ScreenshotController();

  _onFabClick(BuildContext context) async {
    File capturedImage = await _screenshotController.capture();

    String accessToken = await _secureStorage.getAccessToken();

    var authResponse;
    if (accessToken == ""){
      authResponse = await Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticationPage()));
    } else {
      authResponse = true;
    }

    if (authResponse != null && authResponse == true){
      Navigator.push(context, MaterialPageRoute(builder: (context) => GitLabIssueEntryPage(file: capturedImage,)));
    }
  }

  @override
  void initState() {
    super.initState();

    initAsync();
  }

  initAsync() async {
    await _secureStorage.setGitLabConfig(
        widget.customDomain == null ? "https://gitlab.com" : widget.customDomain,
        widget.projectId.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: <Widget>[

        Screenshot(
          controller: _screenshotController,
          child: widget.child
        ),

        DraggableFloatingActionButton(
              data: 'Gitlab Tracker',
              offset: new Offset(MediaQuery.of(context).size.width - 70, 60),
              backgroundColor: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(Images.gitlab, package: 'flutter_gitlab_bug',),
              ),
              onPressed: () => _onFabClick(context),
              appContext: context,
          ),


        ]
      ),
    );
  }
}
