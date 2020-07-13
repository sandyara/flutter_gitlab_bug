
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gitlab_bug/model/issue.dart';
import 'package:flutter_gitlab_bug/model/upload.dart';
import 'package:flutter_gitlab_bug/service/api.dart';
import 'package:flutter_gitlab_bug/widgets/button.dart';
import 'package:flutter_gitlab_bug/widgets/edit_text.dart';
import 'package:flutter_gitlab_bug/widgets/loading_widget.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:package_info/package_info.dart';

class GitLabIssueEntryPage extends StatefulWidget {

  final File file;

  GitLabIssueEntryPage({this.file});

  @override
  _GitLabIssueEntryPageState createState() => _GitLabIssueEntryPageState();
}

class _GitLabIssueEntryPageState extends State<GitLabIssueEntryPage> {

  TextEditingController _titleController = new TextEditingController();

  TextEditingController _descriptionController = new TextEditingController();

  FocusNode _titleFocus = new FocusNode();

  FocusNode _descriptionFocus = new FocusNode();

  bool _titleValidate = false;

  bool _descriptionValidate = false;

  bool _loading = false;

  PackageInfo packageInfo;

  String modelName = "";

  API _api = API();

  String markdownData(String file) {
    return """## Description
${_descriptionController.text}  

## App Info
Platform: ${Platform.isIOS ? "iOS" : Platform.isAndroid ? "Android" : "Other"}  
Device Name: ${modelName}  
App Version: v${packageInfo.version}+${packageInfo.buildNumber}  
Package Name: ${packageInfo.packageName}  

## Screenshot
${file}""";
  }

  _titleControllerListener(){
    setState(() {});
  }

  _descriptionControllerListener(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initAsync();

    _titleController..addListener(()=> _titleControllerListener());
    _descriptionController..addListener(()=> _descriptionControllerListener());
  }

  initAsync() async {
    packageInfo = await PackageInfo.fromPlatform();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    modelName = Platform.isIOS ? (await deviceInfo.iosInfo).utsname.machine : (await deviceInfo.androidInfo).model;
  }

  onSubmitIssue() async {
    if (_titleController.text.isEmpty){
      setState(() {
        _titleValidate = true;
      });
      FocusScope.of(context).requestFocus(_titleFocus);
      return;
    }

    if (_descriptionController.text.isEmpty) {
      setState(() {
        _descriptionValidate = true;
      });
      FocusScope.of(context).requestFocus(_descriptionFocus);
      return;
    }

    setState(() { _loading = true; });
    Upload uploadResponse = await _api.uploadFile(widget.file);
    if (uploadResponse == null){
      //TODO Add Popup for Alert
      return;
    }

    IssueResponse issueResponse = await _api.createIssue(_titleController.text, markdownData(uploadResponse.markdown));
    if (issueResponse == null){
      //TODO Add Popup for Alert
      return;
    } else {
      //TODO Add Popup for Alert
    }

    setState(() { _loading = false; });
    Navigator.pop(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? LoadingWidget(message: "Creating Issue...",) :  Scaffold(
      appBar: AppBar(
        title: Text("Raise Issue", textScaleFactor: 1, style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
       padding: const EdgeInsets.all(10.0),
       child: ListView(
         children: <Widget>[

           EditText(
             "Title *",
             Key("txtTitle"),
             _titleController,
             TextInputType.text,
             focusNode: _titleFocus,
             validate: _titleValidate,
             errorText: "Required Title",
             textCapitalization: TextCapitalization.none,
             marginEdgeInsets: EdgeInsets.only(top: 10),
             onSubmitted: (value) {
               FocusScope.of(context)
                   .requestFocus(_descriptionFocus);
             },
             onChanged: (value) {
               setState(() {
                 _titleValidate = false;
               });
             },
           ),

           EditText(
             "Description *",
             Key("txtDescription"),
             _descriptionController,
             TextInputType.multiline,
             focusNode: _descriptionFocus,
             validate: _descriptionValidate,
             maxLine: 7,
             errorText: "Required Description",
             textCapitalization: TextCapitalization.none,
             marginEdgeInsets: EdgeInsets.only(top: 30),
             onSubmitted: (value) {
               FocusScope.of(context).requestFocus(new FocusNode());
             },
             onChanged: (value) {
               setState(() {
                 _descriptionValidate = false;
               });
             },
           ),

           Padding(padding: EdgeInsets.only(top: 20)),

           Stack(
             children: <Widget>[

               Image.file(widget.file,),

               Positioned(
                 right: 0,
                 child: FloatingActionButton(
                   backgroundColor: Color(0xffE24329),
                   mini: true,
                   onPressed: (){

                   },
                   child: Icon(Icons.edit, color: Colors.white,),
                 ),
               ),


             ],
           )

         ],
       ),
     ),
      bottomNavigationBar: Button("Submit Issue", key: Key('btnSubmit'), onPressed: ()=> onSubmitIssue()),
    );
  }
}