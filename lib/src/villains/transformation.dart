import 'package:abstract_dart/abstract_dart.dart';
import 'package:abstract_flutter/abstract_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_apply_villained/flutter_apply_villained.dart';

VillainApplicator villainTranslate({
  @required Offset from,
  Offset to = Offset.zero,
  Curve curve,
  Object key,
}) {
  return villainField<Offset>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    applyOn: translate,
    interpolationValue: (a) => Offset(a, a),
    field: const OffsetField(),
  );
}

VillainApplicator villainTranslateX({
  @required double from,
  double to,
  Curve curve,
  Object key,
}) {
  return villainTranslate(
      from: Offset(from ?? 0.0, 0.0),
      to: Offset(to ?? 0.0, 0.0),
      curve: curve,
      key: key);
}

VillainApplicator villainTranslateY({
  @required double from,
  double to,
  Curve curve,
  Object key,
}) {
  return villainTranslate(
      from: Offset(0.0, from ?? 0.0),
      to: Offset(0.0, to ?? 0.0),
      curve: curve,
      key: key);
}

VillainApplicator villainScale({
  @required double from,
  double to = 1.0,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    applyOn: scale,
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}

VillainApplicator villainRotate({
  @required double from,
  double to = 0.0,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    applyOn: rotate,
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}
