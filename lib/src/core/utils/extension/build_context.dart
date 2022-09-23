import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/gen/l10n/res.dart';
import 'package:flutter_clean_architecture/gen/l10n/res_en.dart';

extension BuildContextExt on BuildContext {
  Resource res() => Resource.of(this) ?? ResourceEn();
}
