import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location/src/model/address.detail.dart';
import 'package:map_location/src/provider/to.address.dart';

import '../provider/provider.dart';

class MapView extends ConsumerWidget {
  MapView({super.key});
  final initialPosition = const LatLng(23.725190049317277, 90.41272710577839);

  late GoogleMapController mapController;
  late final Completer<GoogleMapController> _completer = Completer();
  final controller = TextEditingController();
  LatLng? _centerCoord;
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) async {
              _completer.complete(controller);
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 14.5,
            ),
            onCameraIdle: () async {
              try {
                final x = MediaQuery.of(context).size.width / 2;
                final y = MediaQuery.of(context).size.height / 2;

                _centerCoord = await mapController
                    .getLatLng(ScreenCoordinate(x: x.toInt(), y: y.toInt()));
                if (_centerCoord != null) {
                  var addressLine = await toAddress(_centerCoord!);
                  ref.read(addressProvider.notifier).set(
                        AddressDetail(
                          locaiton: _centerCoord,
                          addressLine: addressLine,
                        ),
                      );
                }
              } catch (e) {
                //
              }
            },
            markers: {
              Marker(
                onTap: () {},
                draggable: true,
                markerId: const MarkerId('source'),
                position: initialPosition,
                onDragEnd: (position) async {
                  print(position.latitude);
                  print(position.longitude);
                },
              ),
            },
          ),
          const Center(child: Icon(Icons.flag, size: 38)),
          if (ref.watch(addressProvider).addressLine != null)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Text(
                    ref.watch(addressProvider).addressLine ?? '',
                    maxLines: 3,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Position : ${ref.read(addressProvider).locaiton}'),
                        Text('Area: ${ref.read(addressProvider).addressLine}'),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(
          Icons.check,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
