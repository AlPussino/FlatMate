import 'package:flutter/material.dart';

class FlatFloorDropDownButton extends StatefulWidget {
  const FlatFloorDropDownButton({super.key});

  @override
  State<FlatFloorDropDownButton> createState() =>
      _FlatFloorDropDownButtonState();
}

String selectedFloorValue = '0';
List<String> floorOptions =
    List.generate(21, (index) => (index + 0).toString());

class _FlatFloorDropDownButtonState extends State<FlatFloorDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width / 2) - 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color
        ),
        borderRadius: BorderRadius.circular(10), // Border radius
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButton<String>(
          underline: SizedBox(),
          isDense: false,
          menuMaxHeight: 400,
          isExpanded: true,
          alignment: Alignment.centerLeft,
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(
            color: Color(0xff534F4F),
            fontSize: 14,
          ),
          value: selectedFloorValue,
          onChanged: (newValue) {
            setState(() {
              selectedFloorValue = newValue!;
            });
          },
          items: floorOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value == '0' ? "Ground floor" : "${value}th floor"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
