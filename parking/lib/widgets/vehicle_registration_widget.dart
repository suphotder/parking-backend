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
              border: OutlineInputBorder(),
              labelText: 'Enter number',
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: DropdownSearch<String>(
            key: dropDownKey,
            selectedItem: null,
            items: (filter, infiniteScrollProps) => provinceList,
            onChanged: (val) {
              onChangedProvince(val);
            },
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              constraints: BoxConstraints(),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
