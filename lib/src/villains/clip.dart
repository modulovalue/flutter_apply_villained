import 'package:abstract_dart/abstract_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_apply_villained/flutter_apply_villained.dart';

VillainApplicator villainClipRect({
  @required Rect Function(Size size, double t) clipper,
  double from = 0.0,
  double to = 1.0,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    interpolationValue: (a) => a,
    applyOn: (value) {
      return apply((child) {
        return ClipPath(
          clipper: _RectClipper((size) => clipper(size, value), false),
          child: child,
        );
      });
    },
    field: const DoubleField(),
  );
}

VillainApplicator villainClipOval({
  @required Rect Function(Size size, double t) clipper,
  double from = 0.0,
  double to = 1.0,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    interpolationValue: (a) => a,
    applyOn: (value) {
      return apply((child) {
        return ClipPath(
          clipper: _RectClipper((size) => clipper(size, value), true),
          child: child,
        );
      });
    },
    field: const DoubleField(),
  );
}

class _RectClipper extends CustomClipper<Path> {
  final Rect Function(Size size) value;
  final bool isOval;

  const _RectClipper(this.value, this.isOval);

  @override
  Path getClip(Size size) {
    if (isOval) {
      return Path()..addOval(value(size));
    } else {
      return Path()..addRect(value(size));
    }
  }

  @override
  bool shouldReclip(_RectClipper oldClipper) => true;
}
