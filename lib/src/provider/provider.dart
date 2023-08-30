import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_location/src/model/address.detail.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);

final addressProvider =
    NotifierProvider<AddressProvider, AddressDetail>(AddressProvider.new);

class AddressProvider extends Notifier<AddressDetail> {
  @override
  // ignore: library_private_types_in_public_api
  AddressDetail build() => AddressDetail();
  set(AddressDetail address) => state = address;
}
