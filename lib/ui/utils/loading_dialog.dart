import 'package:brian_test/ui/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class DialogLoading {
  static void showSingle(
    BuildContext context, {
    String? title,
  }) {
    _showDialogLoading(context, title);
  }

  static Future<T> show<T>({
    required BuildContext context,
    required Future<T> process,
    String? title,
    ValueSetter<T>? callback,
  }) async {
    var onComplete = () {};

    // ignore: unawaited_futures
    _showDialogLoading(context, title).then((_) {
      onComplete();
    });

    final result = await process;

    onComplete = () {
      if (callback != null) {
        callback(result);
      }
    };

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(result);

    return result;
  }

  static Future<void> _showDialogLoading(
    BuildContext context,
    String? title,
  ) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          elevation: 5.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(70.0),
            ),
          ),
          content: SizedBox(
            width: 171.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 25.0),
                Text(
                  title ?? context.t.dialogLoading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
