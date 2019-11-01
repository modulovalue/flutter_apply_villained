

import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_apply_villained/flutter_apply_villained.dart';

VillainApplicator villainPerspectiveRotate({
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
    applyOn: (value) => perspective(value),
    interpolationValue: (a) => Offset(a, a),
    field: const OffsetField(),
  );
}

VillainApplicator villainPerspectiveRotateX({
  @required double from,
  double to = 0.0,
  Curve curve,
  Object key,
}) =>
    villainPerspectiveRotate(
        from: Offset(from ?? 0.0, 0.0),
        to: Offset(to ?? 0.0, 0.0),
        curve: curve,
        key: key);

VillainApplicator villainPerspectiveRotateY({
  @required double from,
  double to = 0.0,
  Curve curve,
  Object key,
}) =>
    villainPerspectiveRotate(
        from: Offset(0.0, from ?? 0.0),
        to: Offset(0.0, to ?? 0.0),
        curve: curve,
        key: key);
