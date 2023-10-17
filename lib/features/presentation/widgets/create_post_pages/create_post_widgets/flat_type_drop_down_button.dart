import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';

class FlatTypeDropDownButton extends StatefulWidget {
  final post;
  const FlatTypeDropDownButton({super.key, this.post});

  @override
  State<FlatTypeDropDownButton> createState() => _FlatTypeDropDownButtonState();
}

FocusNode houseTypeFocusNode = FocusNode();
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
  void initState() {
    super.initState();
    widget.post != null
        ? selectedHouseTypeValue = widget.post.apartment.apartmentType
        : null;
  }

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
          focusNode: houseTypeFocusNode,
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
          onTap: () {
            houseTypeFocusNode.unfocus();
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
