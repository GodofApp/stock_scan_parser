import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/core/constants/value_types.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final Map<String,dynamic> variables;
  final void Function(String)? onTap;

  ClickableText({
    required this.text,
    this.onTap,
    required this.variables,
  });

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];
    RegExp regex = RegExp(r'\$\d+');
    Iterable<Match> matches = regex.allMatches(text);

    int lastIndex = 0;
    for (Match match in matches) {
      String variable = match.group(0)!;
      int index = int.parse(variable.substring(1));
      String beforeText = text.substring(lastIndex, match.start);
      // Decode the text
      String variableText = text.substring(match.start, match.end);
      String replacedDefaultText = "";
      if(variables.containsKey(variableText)){
        if (variables[variableText]['type'] == ValueTypes.typeValue) {
          replacedDefaultText = variableText.replaceAll(variableText,variables![variableText]['values'][0].toString());
        }else if(variables[variableText]['type'] == ValueTypes.typeIndicator){
          replacedDefaultText = variableText.replaceAll(variableText,variables![variableText]['default_value'].toString());
        }
      }
      spans.add(TextSpan(text: beforeText));

      spans.add(
        TextSpan(
          text: "($replacedDefaultText)",
          style: const TextStyle(
            height: 2,
            color: Colors.blue, // Change this to your desired color
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) {
                onTap!(variableText);
              }
            },
        ),
      );

      lastIndex = match.end;
    }

    spans.add(TextSpan(text: text.substring(lastIndex)));

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: spans,
      ),
    );
  }
}