import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:provider/provider.dart';

class SelectWidget extends StatelessWidget {
  LocationProvider location;
  SelectWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    if (location.isLoading) {
      return Center(
        child: Text("Loading...."),
      );
    } else {
      if (location.getLocationList.isNotEmpty) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFBDC4CB),
            ),
            borderRadius: BorderRadius.circular(28),
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
              'Select location',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            items: location.getLocationList
                .map((item) => DropdownMenuItem<String>(
                      value: item.id,
                      child: Text(
                        item.name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ))
                .toList(),
            value: location.getSelectLocation,
            onChanged: (val) {
              location.updateSelectLocation(val);
              Provider.of<ParkingDataProvider>(context, listen: false)
                  .fetchParkingData(val);
            },
          ),
        );
      } else {
        return Text("Empty");
      }
    }
  }
}
