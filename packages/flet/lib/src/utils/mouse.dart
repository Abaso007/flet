import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/control.dart';
import 'material_state.dart';

MouseCursor? parseMouseCursor(String? cursor,
    [MouseCursor? defaultMouseCursor]) {
  switch (cursor?.toLowerCase()) {
    case "alias":
      return SystemMouseCursors.alias;
    case "allscroll":
      return SystemMouseCursors.allScroll;
    case "basic":
      return SystemMouseCursors.basic;
    case "cell":
      return SystemMouseCursors.cell;
    case "click":
      return SystemMouseCursors.click;
    case "contextmenu":
      return SystemMouseCursors.contextMenu;
    case "copy":
      return SystemMouseCursors.copy;
    case "disappearing":
      return SystemMouseCursors.disappearing;
    case "forbidden":
      return SystemMouseCursors.forbidden;
    case "grab":
      return SystemMouseCursors.grab;
    case "grabbing":
      return SystemMouseCursors.grabbing;
    case "help":
      return SystemMouseCursors.help;
    case "move":
      return SystemMouseCursors.move;
    case "nodrop":
      return SystemMouseCursors.noDrop;
    case "none":
      return SystemMouseCursors.none;
    case "precise":
      return SystemMouseCursors.precise;
    case "progress":
      return SystemMouseCursors.progress;
    case "resizecolumn":
      return SystemMouseCursors.resizeColumn;
    case "resizedown":
      return SystemMouseCursors.resizeDown;
    case "resizedownleft":
      return SystemMouseCursors.resizeDownLeft;
    case "resizedownright":
      return SystemMouseCursors.resizeDownRight;
    case "resizeleft":
      return SystemMouseCursors.resizeLeft;
    case "resizeleftright":
      return SystemMouseCursors.resizeLeftRight;
    case "resizeright":
      return SystemMouseCursors.resizeRight;
    case "resizerow":
      return SystemMouseCursors.resizeRow;
    case "resizeup":
      return SystemMouseCursors.resizeUp;
    case "resizeupdown":
      return SystemMouseCursors.resizeUpDown;
    case "resizeupleft":
      return SystemMouseCursors.resizeUpLeft;
    case "resizeupleftdownright":
      return SystemMouseCursors.resizeUpLeftDownRight;
    case "resizeupright":
      return SystemMouseCursors.resizeUpRight;
    case "resizeuprightdownleft":
      return SystemMouseCursors.resizeUpRightDownLeft;
    case "text":
      return SystemMouseCursors.text;
    case "verticaltext":
      return SystemMouseCursors.verticalText;
    case "wait":
      return SystemMouseCursors.wait;
    case "zoomin":
      return SystemMouseCursors.zoomIn;
    case "zoomout":
      return SystemMouseCursors.zoomOut;
    default:
      return defaultMouseCursor;
  }
}

WidgetStateProperty<MouseCursor?>? parseWidgetStateMouseCursor(
    Control control, String propName,
    [MouseCursor? defaultValue]) {
  var v = control.attrString(propName);
  if (v == null) {
    return null;
  }

  return getWidgetStateProperty<MouseCursor?>(
      jsonDecode(v), (jv) => parseMouseCursor(jv as String), defaultValue);
}
