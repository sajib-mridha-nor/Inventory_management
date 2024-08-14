 
import 'package:flutter/material.dart';

import '../utils/hexcolor.dart';

class CustomDropdown extends StatefulWidget {
  final String hint;
  final String? error;
  final String? initialValue;
  final String? label;
  final TextStyle? labelStyle;
  final List<String> items;
  final bool? require;
  final Function(String? value) onChange;

  const CustomDropdown(
      {Key? key,
      this.labelStyle,this.label,
      required this.items,
      this.require,
      required this.hint,
      this.error,
      required this.onChange,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[ Container(
          child:widget. label != null
              ? 
              
              Column(children: [ RichText(
          text: TextSpan(
            text: widget.label,
            style: widget.labelStyle ?? DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              widget.require == null || widget.require == true
                  ? const TextSpan(
                      text: ' *', style: TextStyle(color: Colors.red))
                  : const TextSpan(),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )],)
             
              : null,
        ),
        SizedBox(
          height: 50,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  validator: (value) {
                    if (widget.require == false) {
                      return null;
                    }
                    if (value == null || value.isEmpty) {
                      if (widget.error == null) {
                        return widget.hint;
                      }
                      return widget.error;
                    }
                    return null;
                  },
                  value:  widget.initialValue,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                  borderRadius: BorderRadius.circular(12.0),
        
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceTint),
                  borderRadius: BorderRadius.circular(12.0),
        
                ),  contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16)
                  ),
                  hint: Text(
                    widget.hint,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  isDense: true,
                  onChanged: (newValue) {
                    widget.onChange(newValue);
                    setState(() {
                      _currentSelectedValue = newValue!;
                      state.didChange(newValue);
                    });
                  },
                  items: widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
