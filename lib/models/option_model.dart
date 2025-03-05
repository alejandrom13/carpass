import 'package:flutter/material.dart';

class Option {
  String title;
  dynamic value;
  IconData? icon;
  Color? iconColor;
  int? id;
  dynamic action;
  bool? selected;
  bool? enabled;
  bool availableOffline = false;

  Option({
    required this.title,
    this.action,
    required this.value,
    this.selected,
    totalCount,
    this.icon,
    this.iconColor,
    this.id,
    this.enabled,
    this.availableOffline = false,
  });

  Option copyWith({
    String? title,
    dynamic code,
    IconData? icon,
    Color? iconcolor,
    int? id,
    dynamic action,
    bool? selected,
    bool? enabled,
  }) {
    return Option(
      title: title ?? this.title,
      value: code ?? value,
      icon: icon ?? this.icon,
      iconColor: iconcolor ?? iconColor,
      id: id ?? this.id,
      action: action ?? this.action,
      selected: selected ?? this.selected,
      enabled: enabled ?? this.enabled,
    );
  }
}

enum OptionType {
  start,
  verification,
  classification,
  shipInspection,
  containerInspection,
  damages,
  pause,
  pauseForm,
  close,
  offline,
}
