
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gitlab_bug/constant.dart';
import 'package:flutter_gitlab_bug/model/auth_response.dart';
import 'package:flutter_gitlab_bug/service/api.dart';
import 'package:flutter_gitlab_bug/widgets/button.dart';
import 'package:flutter_gitlab_bug/widgets/edit_text.dart';
import 'package:flutter_gitlab_bug/widgets/loading_widget.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  bool _emailValidate = false;
  bool _passwordValidate = false;

  bool _loading = false;

  API _api = new API();

  Future<void> login(BuildContext context) async {

    if (_emailController.text.isEmpty){
      setState(() {
        _emailValidate = true;
      });
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordValidate = true;
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return;
    }

    setState(() { _loading = true; });
    AuthResponse authResponse = await _api.login(_emailController.text, _passwordController.text);
    setState(() { _loading = false; });
    if (authResponse != null){
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
      body: SafeArea(
          child: _loading ? LoadingWidget(message: "Authenticating...",) : ListView(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            children: <Widget>[

              Text("GITLAB LOGIN".toUpperCase(), textScaleFactor: 1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),

              Padding(padding: EdgeInsets.only(top: 20)),

              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(Images.gitlab, package: 'flutter_gitlab_bug', width: 100, height: 100,),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              EditText("Email Id",
                Key('btnEmailId'),
                _emailController,
                TextInputType.emailAddress,
                focusNode: _emailFocus,
                validate: _emailValidate,
                marginEdgeInsets: EdgeInsets.only(top: 30),
                errorText: 'Required Email Id',
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                onChanged: (value){
                  if (_emailValidate){
                    setState(() {
                      _emailValidate = false;
                    });
                  }
                },
              ),

              EditText.password('Password',
                Key('btnEmailId'),
                _passwordController,
                TextInputType.text,
                focusNode: _passwordFocus,
                validate: _passwordValidate,
                errorText: 'Required Password',
                textCapitalization: TextCapitalization.none,
                marginEdgeInsets: EdgeInsets.only(top: 20),
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                onChanged: (value){
                  if (_passwordValidate){
                    setState(() {
                      _passwordValidate = false;
                    });
                  }
                },
              ),

              Padding(padding: EdgeInsets.only(top: 40)),

              Button("LOGIN", onPressed: () => login(context)),

              Padding(padding: EdgeInsets.only(top: 20)),

            ],
          )
      ),
    );
  }
}
