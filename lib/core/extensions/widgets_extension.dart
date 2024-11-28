
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  String get routeName =>"/${toString().toLowerCase().replaceAll("page", "")}";
}