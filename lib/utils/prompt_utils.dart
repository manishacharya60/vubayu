import 'package:flutter/material.dart';

String buildPrompt(
    BuildContext context, String? location, TimeOfDay time, String season) {
  final timeString = time.format(context);
  return 'Write a story set in $location during the $season season at $timeString.';
}
