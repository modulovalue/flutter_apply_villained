import 'dart:ui';

import 'package:abstract_dart/abstract_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_apply_villained/flutter_apply_villained.dart';
import 'package:intersperse/intersperse.dart';

// find better category once abstraction clear

Widget villainizeText(
  String text, {
  @required Applicator Function(Duration, int) apply,
  Duration Function(String, int) ms,
  int totalDurationInMS,
}) {
  int realTotalDuration(int index) =>
      (((totalDurationInMS ?? 50) / text.length) * index)
          .floorToDouble()
          .toInt();

  Applicator applyAt(int index) {
    return apply(
        (ms ?? (text, a) => Duration(milliseconds: realTotalDuration(a)))(
            text, index),
        index);
  }

  return onWrapCenter() >>
      intersperse(
          const Text(" "),
          text
              .split(" ")
              .asMap()
              .entries
              .fold(<MapEntry<int, Widget>>[],
                  (List<MapEntry<int, Widget>> prev,
                      MapEntry<int, String> cur) {
                int lastCount;

                if (prev.isEmpty) {
                  lastCount = 0;
                } else {
                  lastCount = prev.last.key + 1;
                }

                final all = cur.value.split("").asMap().entries.map((entry) {
                  return applyAt(lastCount + entry.key) >
                      Text(entry.value,
                          style: const TextStyle(letterSpacing: -0.7));
                });

                return prev
                  ..add(MapEntry(
                      lastCount + cur.key, onRowMinCenterCenter() >> all));
              })
              .map((entry) => entry.value)
              .toList());
}

VillainApplicator villainColor({
  @required Color from,
  @required Color to,
  @required Applicator Function(Color color) parent,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    from: 0.0,
    to: 1.0,
    applyOn: (value) =>
        apply((child) => parent(Color.lerp(from, to, value)) > child),
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}

VillainApplicator villainPadding({
  @required EdgeInsets from,
  @required EdgeInsets to,
  Curve curve,
  Object key,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    from: 0.0,
    to: 1.0,
    applyOn: (value) => apply((child) =>
        Padding(padding: EdgeInsets.lerp(from, to, value), child: child)),
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}

VillainApplicator villainBlur({
  double from = 0.0,
  double to = 10.0,
  Curve curve,
  Object key,
  Widget whileZero,
}) {
  return villainField<double>(
    key: key,
    curve: curve,
    to: to,
    from: from,
    applyOn: (value) => apply((child) {
      return BackdropFilter(
        key: ValueKey(value),
        filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
        child: child,
      );
    }),
    interpolationValue: (a) => a,
    field: const DoubleField(),
  );
}
