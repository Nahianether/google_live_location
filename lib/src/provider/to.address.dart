import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<String> toAddress(LatLng coords) async {
  String addressLine = '';
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(coords.latitude, coords.longitude);
    final thoroughfare = placemarks.first.thoroughfare!.isEmpty
        ? ''
        : '${placemarks.first.thoroughfare},';
    final subLocality = placemarks.first.subLocality!.isEmpty
        ? ''
        : '${placemarks.first.subLocality},';
    final locality = '${placemarks.first.locality}';
    addressLine = '$thoroughfare $subLocality $locality';
  } catch (e) {
    //
  }
  return addressLine;
}
