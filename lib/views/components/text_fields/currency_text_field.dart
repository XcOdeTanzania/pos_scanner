import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef CurrencyTextfieldOnChange = Function(String);

class CurrencyTextfield extends StatelessWidget {
  final String hitText;
  final String labelText;
  final int maxLines;
  final String message;
  final String prefix;
  final String surfix;
  final bool isEditable;
  final CurrencyTextfieldOnChange onChange;
  final GlobalKey<FormFieldState> formFieldKey;

  final FocusNode focusNode;

  final TextEditingController textEditingController;

  CurrencyTextfield(
      {Key key,
      @required this.hitText,
      @required this.labelText,
      @required this.focusNode,
      @required this.textEditingController,
      @required this.maxLines,
      @required this.message,
      this.isEditable = true,
      this.prefix,
      this.surfix,
      this.onChange,
      this.formFieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: TextFormField(
          enabled: isEditable,
          onChanged: onChange,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          key: formFieldKey,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            new CurrencyInputFormatter()
          ],
          controller: textEditingController,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefix: prefix != null ? Text(prefix) : null,
            suffix: surfix != null ? Text(surfix) : null,
            hintText: hitText,
            labelText: labelText,
            border: InputBorder.none,
          ),
          validator: (value) {
            if (message != null) {
              if (value.isEmpty) {
                return "\t\t\t\t\t\t\t\t\t\t\t\t\t\t" + message;
              } else
                return null;
            } else
              return null;
          },
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter =
        new NumberFormat.simpleCurrency(decimalDigits: 0, name: '');

    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
