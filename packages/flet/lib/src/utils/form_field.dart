import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controls/create_control.dart';
import '../models/control.dart';
import 'borders.dart';
import 'edge_insets.dart';
import 'icons.dart';
import 'text.dart';

enum FormFieldInputBorder { outline, underline, none }

FormFieldInputBorder? parseFormFieldInputBorder(String? value,
    [FormFieldInputBorder? defValue]) {
  if (value == null) {
    return defValue;
  }
  return FormFieldInputBorder.values.firstWhereOrNull(
          (e) => e.name.toLowerCase() == value.toLowerCase()) ??
      defValue;
}

TextInputType? parseTextInputType(String? value, [TextInputType? defValue]) {
  switch (value?.toLowerCase()) {
    case "datetime":
      return TextInputType.datetime;
    case "email":
      return TextInputType.emailAddress;
    case "multiline":
      return TextInputType.multiline;
    case "name":
      return TextInputType.name;
    case "none":
      return TextInputType.none;
    case "number":
      return TextInputType.number;
    case "phone":
      return TextInputType.phone;
    case "streetaddress":
      return TextInputType.streetAddress;
    case "text":
      return TextInputType.text;
    case "url":
      return TextInputType.url;
    case "visiblepassword":
      return TextInputType.visiblePassword;
    default:
      return defValue;
  }
}

InputDecoration buildInputDecoration(
    BuildContext context,
    Control control,
    {Control? prefix,
    Control? prefixIcon,
    Control? suffix,
    Control? suffixIcon,
    Control? icon,
    Control? counter,
    Widget? customSuffix,
    bool focused = false,
    bool disabled = false,
    bool? adaptive}) {
  String? label = control.attrString("label", "")!;
  FormFieldInputBorder inputBorder = parseFormFieldInputBorder(
    control.attrString("border"),
    FormFieldInputBorder.outline,
  )!;
  var iconStr = parseIcon(control.attrString("icon"));

  var prefixIconStr = parseIcon(control.attrString("prefixIcon"));
  var prefixText = control.attrString("prefixText");
  var suffixIconStr = parseIcon(control.attrString("suffixIcon"));
  var suffixText = control.attrString("suffixText");

  var bgcolor = control.attrColor("bgcolor", context);
  var focusedBgcolor = control.attrColor("focusedBgcolor", context);
  var fillColor = control.attrColor("fillColor", context);
  var hoverColor = control.attrColor("hoverColor", context);
  var borderColor = control.attrColor("borderColor", context);

  var borderRadius = parseBorderRadius(control, "borderRadius");
  var focusedBorderColor = control.attrColor("focusedBorderColor", context);
  var borderWidth = control.attrDouble("borderWidth");
  var focusedBorderWidth = control.attrDouble("focusedBorderWidth");

  InputBorder? border;
  if (inputBorder == FormFieldInputBorder.underline) {
    border = const UnderlineInputBorder();
  } else if (inputBorder == FormFieldInputBorder.none) {
    border = InputBorder.none;
  } else if (inputBorder == FormFieldInputBorder.outline ||
      borderRadius != null ||
      borderColor != null ||
      borderWidth != null) {
    border = const OutlineInputBorder();
    if (borderRadius != null) {
      border =
          (border as OutlineInputBorder).copyWith(borderRadius: borderRadius);
    }
    if (borderColor != null || borderWidth != null) {
      border = (border as OutlineInputBorder).copyWith(
          borderSide: borderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  color: borderColor ??
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                  width: borderWidth ?? 1.0));
    }
  }

  InputBorder? focusedBorder;
  if (borderColor != null ||
      borderWidth != null ||
      focusedBorderColor != null ||
      focusedBorderWidth != null) {
    focusedBorder = border?.copyWith(
        borderSide: borderWidth == 0
            ? BorderSide.none
            : BorderSide(
                color: focusedBorderColor ??
                    borderColor ??
                    Theme.of(context).colorScheme.primary,
                width: focusedBorderWidth ?? borderWidth ?? 2.0));
  }

  return InputDecoration(
      enabled: !disabled,
      contentPadding: parseEdgeInsets(control, "contentPadding"),
      isDense: control.attrBool("dense"),
      label: label != "" ? Text(label) : null,
      labelStyle: parseTextStyle(Theme.of(context), control, "labelStyle"),
      border: border,
      enabledBorder: border,
      focusedBorder: focusedBorder,
      hoverColor: hoverColor,
      icon: icon != null
          ? createControl(control, icon.id, control.isDisabled,
              parentAdaptive: adaptive)
          : iconStr !=null? Icon(iconStr): null,
      filled: control.attrBool("filled", false)!,
      fillColor: fillColor ?? (focused ? focusedBgcolor ?? bgcolor : bgcolor),
      hintText: control.attrString("hintText"),
      hintStyle: parseTextStyle(Theme.of(context), control, "hintStyle"),
      helperText: control.attrString("helperText"),
      helperStyle: parseTextStyle(Theme.of(context), control, "helperStyle"),
      counterText: control.attrString("counterText"),
      counterStyle: parseTextStyle(Theme.of(context), control, "counterStyle"),
      counter: counter != null
          ? createControl(control, counter.id, control.isDisabled,
              parentAdaptive: adaptive)
          : null,
      errorText: control.attrString("errorText") != ""
          ? control.attrString("errorText")
          : null,
      errorStyle: parseTextStyle(Theme.of(context), control, "errorStyle"),
      prefixIcon: prefixIcon != null
          ? createControl(control, prefixIcon.id, control.isDisabled,
              parentAdaptive: adaptive)
          : prefixIconStr !=null? Icon(prefixIconStr): null,
      prefixText: prefixText,
      prefixStyle: parseTextStyle(Theme.of(context), control, "prefixStyle"),
      prefix: prefix != null
          ? createControl(control, prefix.id, control.isDisabled,
              parentAdaptive: adaptive)
          : null,
      suffix: suffix != null
          ? createControl(control, suffix.id, control.isDisabled,
              parentAdaptive: adaptive)
          : null,
      suffixIcon: suffixIcon != null
          ? createControl(control, suffixIcon.id, control.isDisabled,
              parentAdaptive: adaptive)
          : suffixIconStr !=null? Icon(suffixIconStr): customSuffix,
      suffixText: suffixText,
      suffixStyle: parseTextStyle(Theme.of(context), control, "suffixStyle"),
      );
}

OverlayVisibilityMode parseVisibilityMode(String type) {
  switch (type.toLowerCase()) {
    case "never":
      return OverlayVisibilityMode.never;
    case "notediting":
      return OverlayVisibilityMode.notEditing;
    case "editing":
      return OverlayVisibilityMode.editing;
    case "always":
      return OverlayVisibilityMode.always;
  }
  return OverlayVisibilityMode.always;
}
