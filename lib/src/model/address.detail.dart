import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressDetail {
  LatLng? locaiton;
  String? addressLine;

  AddressDetail({
    this.locaiton,
    this.addressLine,
  });

  AddressDetail copyWith({
    LatLng? location,
    String? addressLine,
  }) =>
      AddressDetail(
        locaiton: locaiton ?? locaiton,
        addressLine: addressLine ?? this.addressLine,
      );
}
