import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:parking/utils/constants.dart';

class VehicleRegistrationWidget extends StatelessWidget {
  String selectProvince;
  Function onChangedNumber;
  Function onChangedProvince;

  VehicleRegistrationWidget({
    super.key,
    required this.selectProvince,
    required this.onChangedNumber,
    required this.onChangedProvince,
  });

  @override
  Widget build(BuildContext context) {
    final dropDownKey = GlobalKey<DropdownSearchState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: TextField(
            onChanged: (val) {
              onChangedNumber(val);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              labelText: 'Enter number',
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: DropdownButton2(
            dropdownStyleData: const DropdownStyleData(
              scrollPadding: EdgeInsets.only(left: 12, right: 0),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
            alignment: Alignment.center,
            underline: SizedBox.shrink(),
            hint: Text(
              'Select province',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            items: provinceList
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ))
                .toList(),
            value: selectProvince != "" ? selectProvince : null,
            onChanged: (val) {
              onChangedProvince(val);
            },
          ),
        ),
      ],
    );
  }
}
