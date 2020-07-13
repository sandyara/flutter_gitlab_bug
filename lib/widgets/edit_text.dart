import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditText extends StatefulWidget {
  TextEditingController controller;
  String hint;
  String errorText;
  TextInputType inputType;
  TextStyle textStyle;
  TextAlign textAlign;
  FocusNode focusNode = new FocusNode();
  EdgeInsets marginEdgeInsets;
  TextCapitalization textCapitalization;
  TextInputAction textInputAction;
  int maxLine;

  Key key;

  bool validate = false;
  bool autofocus = false;
  bool isPasswordField = false;
  bool removeDecoration = false;
  bool restrictSpace = false;
  int maxLength = 1000;
  bool enabled = true;

  ValueChanged<String> onChanged = (terms) {};
  ValueChanged<String> onSubmitted = (terms) {};

  EditText(this.hint, this.key, this.controller, this.inputType,
      {this.marginEdgeInsets,
      this.focusNode,
      this.onSubmitted,
      this.onChanged,
      this.maxLength,
      this.autofocus = false,
      this.textCapitalization,
      this.enabled = true,
      this.errorText,
      this.maxLine,
      this.restrictSpace = false,
      this.textAlign = TextAlign.left,
      this.textStyle,
      this.textInputAction = TextInputAction.next,
      this.validate});

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  VoidCallback onPressed;

  String text;

  bool isVisible = false;

  setFormSubmitted(ValueChanged<String> formSubmitted) {
    this.widget.onSubmitted = formSubmitted;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: widget.marginEdgeInsets == null
          ? EdgeInsets.all(0)
          : widget.marginEdgeInsets,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Text(
          widget.hint,
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        TextFormField(
          key: widget.key,
          controller: widget.controller,
          enableInteractiveSelection: true,
          obscureText: widget.isPasswordField && !isVisible ? true : false,
          textInputAction: widget.textInputAction,
          textAlign: widget.textAlign,
          maxLines: widget.maxLine,
          style:
              widget.textStyle == null ? Theme.of(context).textTheme.subtitle1 : widget.textStyle,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted != null
              ? widget.onSubmitted
              : (text) {
                  if (widget.textInputAction == TextInputAction.done) {
                    FocusScope.of(context).unfocus();
                  }
                },
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          inputFormatters: widget.isPasswordField ||
                  widget.inputType == TextInputType.emailAddress ||
                  widget.restrictSpace
              ? [
                  new BlacklistingTextInputFormatter(new RegExp('[\\ ]')),
                ]
              : null,
          decoration: new InputDecoration(
            errorText: widget.validate
                ? widget.errorText == null ? "Required *" : widget.errorText
                : null,
            labelStyle: widget.focusNode == null
                ? new TextStyle(color: Colors.black54)
                : (widget.focusNode.hasFocus
                    ? TextStyle(color: Theme.of(context).textSelectionColor)
                    : TextStyle(color: Colors.black54)),
            fillColor: Color(0xfff7f7f7),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                  color: widget.removeDecoration
                      ? Colors.transparent
                      : Colors.black54),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                  color: widget.removeDecoration
                      ? Colors.transparent
                      : Colors.black12),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                  color: widget.removeDecoration
                      ? Colors.transparent
                      : Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                  color: widget.removeDecoration
                      ? Colors.transparent
                      : Theme.of(context).primaryColor,
                  width: 2),
            ),
            suffixIcon: widget.isPasswordField
                ? GestureDetector(
                    child: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
//                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
            )
                : null,
          ),
          keyboardType: widget.inputType,
          textCapitalization: widget.textCapitalization == null
              ? TextCapitalization.none
              : widget.textCapitalization,
        )
      ]),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
