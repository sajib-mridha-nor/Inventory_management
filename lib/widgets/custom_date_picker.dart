import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
 
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
 

class CustomDatePicker extends StatelessWidget {
  final Function(DateTime? v) onChange;
  final String label;
  final String hint;
  final String? error;
  final TextStyle? labelStyle;
  final bool require;
  final String? initialValue;
  final String dateMask;

    CustomDatePicker(
      {Key? key,
      required this.label,
      required this.hint,
      this.require = true,
      this.initialValue,
      required this.onChange,
      this.labelStyle,
      this.error,
      this.dateMask = 'd MMMM, yyyy'})
      : super(key: key);

      var selectedDate;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: label,
            style: labelStyle ?? DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              require == true
                  ? const TextSpan(
                      text: ' *', style: TextStyle(color: Colors.red))
                  : const TextSpan(),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
       DateTimeField(
        decoration: InputDecoration(
            
            
              suffixIcon:    Icon(
                        Icons.calendar_month
                             ,
                          color: Theme.of(context).colorScheme.surfaceTint),
                       
                     
                 
              hintText:  hint,
              counterText: "",
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0),
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

              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
       
        format: DateFormat("yyyy-MM-dd"),
        onShowPicker: (context, currentValue) async {

      
      selectedDate= await showDatePicker(
      
          
            context: context,
            
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
              onChange(selectedDate);

              return selectedDate;
         
      
          // return await showDatePicker(
          
          //   onDatePickerModeChange: (value){
          //     print(value);
          //   },
            
          //   context: context,
            
          //   firstDate: DateTime(1900),
          //   initialDate: currentValue ?? DateTime.now(),
          //   lastDate: DateTime(2100),
          // );
          
       
        },
      ),
       
       ],
    );
  }
}
