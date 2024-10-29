import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputNumberWithThousandFormatter extends StatefulWidget {
  final Function(int)? onSubmitted;
  final Function(int)? onChanged;
  final bool isRequired;
  final String labelText;
  final String hintText;
  final int? initialValue;

  InputNumberWithThousandFormatter({
    this.onSubmitted,
    this.onChanged,
    this.isRequired = false,
    this.labelText = 'Enter Amount',
    this.hintText = '',
    this.initialValue = 0,
    Key? key,
  }) : super(key: key);

  @override
  InputNumberWithThousandFormatterState createState() =>
      InputNumberWithThousandFormatterState();
}

class InputNumberWithThousandFormatterState
    extends State<InputNumberWithThousandFormatter> {
  late TextEditingController _controller;
  final NumberFormat _formatter = NumberFormat('#,##0');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.initialValue != null) {
      _setFormattedValue(widget.initialValue!);
    }

    _controller.addListener(() {
      final text = _controller.text.replaceAll(',', '');
      if (text.isNotEmpty) {
        final value = int.tryParse(text) ?? 0;
        _controller.value = TextEditingValue(
          text: _formatter.format(value),
          selection: TextSelection.collapsed(
            offset: _formatter.format(value).length,
          ),
        );

        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      }
    });
  }

  void _setFormattedValue(int value) {
    final formattedValue = _formatter.format(value);
    _controller.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  @override
  void didUpdateWidget(InputNumberWithThousandFormatter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _setFormattedValue(widget.initialValue ?? 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendData() {
    if (widget.onSubmitted != null) {
      final rawValue = _controller.text.replaceAll(',', '');
      final amount = int.tryParse(rawValue) ?? 0;
      widget.onSubmitted!(amount);
    } else {
      widget.onSubmitted!(0);
    }
  }

  bool submit() {
    if (widget.isRequired) {
      if(_formKey.currentState!.validate()){
        sendData();
        return true;
      } else {
        return false;
      }
    } else {
      sendData();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              errorText: _errorMessage,
            ),
            validator: (value) {
              if (widget.isRequired && (value == null || value.isEmpty || value == '0')) {
                setState(() {
                  _errorMessage = 'This field is required';
                });
                return _errorMessage;
              }
              setState(() {
                _errorMessage = null;
              });
              return null;
            },
            onFieldSubmitted: (value) {
              submit();
            },
            onChanged: (value) {
              _formKey.currentState!.validate();
              final rawValue = _controller.text.replaceAll(',', '');
              final amount = int.tryParse(rawValue) ?? 0;
              if (widget.onChanged != null) {
                widget.onChanged!(amount);
              }
            },
          ),
        ],
      ),
    );
  }
}
