import 'package:abstract_dart/abstract_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_apply_villained/flutter_apply_villained.dart';

VillainApplicator villainOpacity({
  double from = 0.0,
  double to = 1.0,
  Curve curve,
  Object key,
  Widget whileZero,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    applyOn: (value) => apply((child) => value == 0.0 && whileZero != null
        ? whileZero
        : Opacity(opacity: value, child: child)),
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}

VillainApplicator villainFadeIn({Curve curve, Object key, Widget whileZero}) =>
    villainOpacity(
        from: 0.0, to: 1.0, curve: curve, key: key, whileZero: whileZero);

VillainApplicator villainFadeOut({Curve curve, Object key, Widget whileZero}) =>
    villainOpacity(
        from: 1.0, to: 0.0, curve: curve, key: key, whileZero: whileZero);
