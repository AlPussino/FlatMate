import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';

class FlatFloorDropDownButton extends StatefulWidget {
  final post;
  const FlatFloorDropDownButton({super.key, this.post});

  @override
  State<FlatFloorDropDownButton> createState() =>
      _FlatFloorDropDownButtonState();
}

FocusNode floorFocusNode = FocusNode();
String selectedFloorValue = '0';
List<String> floorOptions =
    List.generate(21, (index) => (index + 0).toString());

class _FlatFloorDropDownButtonState extends State<FlatFloorDropDownButton> {
  @override
  void initState() {
    super.initState();
    widget.post != null
        ? selectedFloorValue = '${widget.post.apartment.floor}'
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
        child: DropdownButton<String>(
          focusNode: floorFocusNode,
          underline: SizedBox(),
          isDense: false,
          menuMaxHeight: 400,
          isExpanded: true,
          alignment: Alignment.centerLeft,
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(
            color: AppColor.greyColor,
            fontSize: 14,
          ),
          value: selectedFloorValue,
          onChanged: (newValue) {
            setState(() {
              floorFocusNode.unfocus();
              selectedFloorValue = newValue!;
            });
          },
          onTap: () {
            floorFocusNode.unfocus();
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
