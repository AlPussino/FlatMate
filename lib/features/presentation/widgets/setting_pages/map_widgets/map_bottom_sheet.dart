import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void mapBottomSheet(BuildContext context, ScreenCoordinate coordinate) {
  log("${coordinate}");
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    context: context,
    builder: (_) {
      return SizedBox(
        height: 100,
        child: Center(
          child: ListTile(
            onTap: () async {
              await Clipboard.setData(
                ClipboardData(text: coordinate.toString()),
              );
              Navigator.pop(context);
            },
            leading: Icon(Icons.copy),
            title: Text('Copy address'),
          ),
        ),
      );
    },
  );
}
