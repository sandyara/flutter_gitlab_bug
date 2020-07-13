
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergitlabbug/widgets/edit_text.dart';
import 'package:markdown_widget/markdown_widget.dart';

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

  String get markdownData {
    return """
      ![Issue Screenshot](${widget.file.path})
      
      ## ${_titleController.text}
      
      ${_descriptionController.text}
    """;
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

    _titleController..addListener(()=> _titleControllerListener());
    _descriptionController..addListener(()=> _descriptionControllerListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

           Container(
             padding: const EdgeInsets.only(top: 25, bottom: 10),
             alignment: Alignment.centerLeft,
             child: Text("Preview", textScaleFactor: 1, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
           ),

           Flexible(
             child: Container(
               height: 800,
               child: MarkdownWidget(data: markdownData)
             )
           )

         ],
       ),
     ),
    );
  }
}