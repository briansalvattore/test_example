import 'package:brian_test/data/layer_data.dart';
import 'package:brian_test/data/logger_interface.dart';

class LayerDomain {
  factory LayerDomain._() => _singleton;

  LayerDomain._internal();

  static final LayerDomain _singleton = LayerDomain._internal();

  // ignore: prefer_constructors_over_static_methods
  static LayerDomain get instance => LayerDomain._();

  static Future<LayerDomain> get initAndInstance async {
    await LayerData.instance;

    return LayerDomain._();
  }

  void recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) {
    log.wtf('exception=[$exception] stack=[$stack] fatal=[$fatal]');

    LayerData.repository.firebase.sendCrash(exception, stack, fatal: fatal);
  }
}
