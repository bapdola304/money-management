import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TabItem {
  final String artboard;

  final String stateMachine;

  SMIBool? status;
  UniqueKey? id = UniqueKey();

  TabItem({
    this.stateMachine = "",
    this.artboard = "",
    this.status,
  });
}
