import 'package:abstract_dart/abstract_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';

class OffsetField with FieldOps<Offset> {
  const OffsetField();

  @override
  Group_<Offset> get addition => const OffsetSumGroup();

  @override
  Group_<Offset> get multiplication => const OffsetProductGroup();
}

class OffsetSumGroup with GroupOps<Offset> {
  const OffsetSumGroup();

  @override
  Offset identity() => Offset.zero;

  @override
  Offset operate(Offset a, Offset b) => a + b;

  @override
  Offset inverse(Offset a, Offset b) => a - b;
}

class OffsetProductGroup with GroupOps<Offset> {
  const OffsetProductGroup();

  @override
  Offset operate(Offset a1, Offset a2) => Offset(a1.dx * a2.dx, a1.dy * a2.dy);

  @override
  Offset inverse(Offset a1, Offset a2) => Offset(a1.dx / a2.dx, a1.dy / a2.dy);

  @override
  Offset identity() => const Offset(1.0, 1.0);
}

class ApplicatorMonoid with MonoidOps<Applicator> {
  @override
  Applicator identity() => apply;

  @override
  Applicator operate(Applicator a, Applicator b) => a & b;
}
