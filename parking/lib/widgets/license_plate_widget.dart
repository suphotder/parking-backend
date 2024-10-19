import 'package:flutter/material.dart';

class LicensePlateWidget extends StatelessWidget {
  String? licensePlate;
  int? numberSpaces;

  LicensePlateWidget({
    super.key,
    required this.licensePlate,
    required this.numberSpaces,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: licensePlate != null
          ? [
              Text(
                "No ${numberSpaces}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                "${licensePlate!.split(":")[0]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${licensePlate!.split(":")[1]}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]
          : [
              Text(
                "No ${numberSpaces}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                "Vacant",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
    );
  }
}
