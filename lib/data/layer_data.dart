import 'package:brian_test/data/firebase/firebase_impl.dart';
import 'package:brian_test/data/firebase/firebase_interface.dart';
import 'package:brian_test/data/google/google_impl.dart';
import 'package:brian_test/data/google/google_interface.dart';
import 'package:brian_test/data/http/http_impl.dart';
import 'package:brian_test/data/http/http_interface.dart';
import 'package:brian_test/data/location/location_impl.dart';
import 'package:brian_test/data/location/location_interface.dart';
import 'package:brian_test/data/storage/storage_impl.dart';
import 'package:brian_test/data/storage/storage_interface.dart';
import 'package:get_it/get_it.dart';

class LayerData {
  LayerData._internal();

  factory LayerData._() => _singleton;

  static final LayerData _singleton = LayerData._internal();

  // ignore: prefer_constructors_over_static_methods
  static LayerData get repository => LayerData._();

  static Future<void> get instance async {
    final getIt = GetIt.instance
      ..registerSingleton<StorageImpl>(
        StorageImpl.instance(),
      );

    await Future.wait([
      getIt.get<StorageImpl>().init(),
      FirebaseImpl.init(),
    ]);
  }

  Firebase get firebase => FirebaseImpl();

  Storage get storage => GetIt.instance.get<StorageImpl>();

  Google get google => GoogleImpl();

  Location get location => LocationImpl();

  Http get http => HttpImpl();
}
