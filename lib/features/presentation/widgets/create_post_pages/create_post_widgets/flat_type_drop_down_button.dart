import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';

class FlatTypeDropDownButton extends StatefulWidget {
  const FlatTypeDropDownButton({super.key});

  @override
  State<FlatTypeDropDownButton> createState() => _FlatTypeDropDownButtonState();
}

String selectedHouseTypeValue = 'CONDO';
List<String> houseTypeOptions = [
  'CONDO',
  'MINI_CONDO',
  'FLAT',
  'HOSTEL',
  'HOUSE',
  'WHOLE_HOUSE'
];

class _FlatTypeDropDownButtonState extends State<FlatTypeDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width / 2) - 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.greyColor, // Border color
        ),
        borderRadius: BorderRadius.circular(10), // Border radius
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButton(
          isExpanded: true,
          underline: SizedBox(),
          alignment: Alignment.centerLeft,
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(
            color: AppColor.greyColor,
            fontSize: 14,
          ),
          value: selectedHouseTypeValue,
          onChanged: (newValue) {
            setState(() {
              selectedHouseTypeValue = newValue!;
            });
          },
          items: houseTypeOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
