import 'package:flutter/material.dart';

class FormGroupPanel extends StatelessWidget {
  final Widget inputs;
  final IconData icon;
  final String title;
  final EdgeInsetsGeometry? iconPadding;
  final String? errorMessage;
  const FormGroupPanel({
    Key? key,
    required this.inputs,
    required this.icon,
    required this.title,
    this.iconPadding,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: iconPadding ?? const EdgeInsets.only(top: 28.0),
              // child: InputHeaderIcon(icon: icon),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: inputs,
              ),
            ),
          ],
        ),
        errorMessage != null
            ? Text(
              errorMessage ?? "",
              // fontSize: 14, colors: Colors.red
            )
            : const SizedBox(),
      ],
    );
  }
}
