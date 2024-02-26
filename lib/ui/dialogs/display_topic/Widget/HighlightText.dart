import 'package:flutter/material.dart';

Widget highlightText(String text, String pattern) {
    final patternRegExp = RegExp(pattern, caseSensitive: false);
    final matches = patternRegExp.allMatches(text);

    if (matches.isEmpty) {
      return Text(text);
    }

    List<TextSpan> children = [];
    int lastMatchEnd = 0;

    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        children.add(
          TextSpan(text: text.substring(lastMatchEnd, match.start)),
        );
      }
      children.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      children.add(
        TextSpan(text: text.substring(lastMatchEnd)),
      );
    }

    return RichText(
      text: TextSpan(children: children),
    );
  }
