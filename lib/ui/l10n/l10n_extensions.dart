import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension L10nExtensions on BuildContext {
  //? normal mode
  AppLocalizations get appLocalizations {
    return AppLocalizations.of(this)!;
  }

  //? sugar syntax mode
  AppLocalizations get t {
    return AppLocalizations.of(this)!;
  }
}
