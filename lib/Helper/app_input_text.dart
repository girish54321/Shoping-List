import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String? hint;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final TextEditingController? textEditingController;
  final bool? password;
  final Function(String)? changeFous;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final String? errorText;
  final Function(String)? onChnaged;
  final Function(String?)? onSaved;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;

  // ignore: use_key_in_widget_constructors
  const InputText({
    Key? key,
    this.hint,
    this.rightIcon,
    this.leftIcon,
    this.textEditingController,
    this.password,
    this.changeFous,
    this.focusNode,
    this.textInputType,
    this.errorText,
    this.onChnaged,
    this.validator,
    this.onSaved,
    this.textInputAction,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 18, top: 9),
      decoration: const BoxDecoration(),
      child: TextFormField(
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        focusNode: widget.focusNode,
        onChanged: widget.onChnaged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.changeFous,
        obscureText: widget.password ?? false,
        controller: widget.textEditingController,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.hint,
          errorText: widget.errorText,
          prefixIcon: widget.leftIcon,
          suffixIcon: widget.rightIcon,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
