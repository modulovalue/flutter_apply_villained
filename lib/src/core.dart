import 'package:abstract_dart/abstract_dart.dart';
import 'package:abstract_lerp/abstract_lerp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apply/flutter_apply.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VillainApplicator extends IDApplicator {
  static const Duration defltInTime = Duration(milliseconds: 300);
  static const Curve defaultCurve = Curves.easeInOut;
  final Duration _delay;
  final Duration _inTime;
  final VillainLoopMode _loopMode;
  final Widget Function(Widget child, Duration delay, Duration inTime,
      VillainLoopMode loopMode) applyVillain;

  const VillainApplicator({
    @required this.applyVillain,
    Duration delay,
    Duration inTime,
    VillainLoopMode loopMode,
  })  : this._delay = delay ?? Duration.zero,
        this._inTime = inTime ?? VillainApplicator.defltInTime,
        this._loopMode = loopMode ?? VillainLoopMode.dont;

  Duration get duration => _delay + _inTime;

  /// Delays the villain by [moreDelay].
  ///
  /// Delaying will still apply the villain but it will not start animating until
  /// the delay time has passed.
  ///
  /// Calling [delay] multiple times accumulates all the delay times.
  VillainApplicator delay(Duration moreDelay) =>
      copyWith(delay: _delay + (moreDelay ?? Duration.zero));

  VillainApplicator delayMS(int ms) => delay(Duration(milliseconds: ms ?? 0));

  VillainApplicator loopRepeat() => copyWith(mode: VillainLoopMode.repeat);

  VillainApplicator loopPingPong() => copyWith(mode: VillainLoopMode.pingpong);

  VillainApplicator loopDont() => copyWith(mode: VillainLoopMode.dont);

  /// Sets how long the villain should take.
  ///
  /// If called multiple times only the last inTime will be considered.
  VillainApplicator inTime(Duration newInTime) => copyWith(inTime: newInTime);

  VillainApplicator inTimeMS(int ms) => inTime(Duration(milliseconds: ms));

  @override
  Widget applyWidget(Widget child) =>
      applyVillain(child, _delay, _inTime, _loopMode);

  VillainApplicator copyWith({
    Duration delay,
    VillainLoopMode mode,
    Duration inTime,
    Widget Function(Widget child, Duration delay, Duration inTime,
            VillainLoopMode loopMode)
        applyVillain,
  }) {
    return VillainApplicator(
      delay: delay ?? this._delay,
      loopMode: mode ?? this._loopMode,
      inTime: inTime ?? this._inTime,
      applyVillain: applyVillain ?? this.applyVillain,
    );
  }
}

enum VillainLoopMode {
  dont,
  pingpong,
  repeat,
}

/// https://en.wikipedia.org/wiki/Field_(mathematics)
VillainApplicator villainField<T>({
  @required Applicator Function(T) applyOn,
  @required T from,
  @required T to,
  @required T Function(double) interpolationValue,
  @required Field_<T> field,
  Duration inTime = VillainApplicator.defltInTime,
  Duration delay = Duration.zero,
  Curve curve,
  Object key,
}) {
  return VillainApplicator(
      inTime: inTime,
      delay: delay,
      applyVillain: (child, delay, inTime, loopMode) {
        return HookBuilder(
          key: key != null ? ValueKey(key) : null,
          builder: (context) {
            final animationController = useAnimationController(
              duration: inTime + delay,
              keys: key != null ? [key] : [],
              animationBehavior: AnimationBehavior.preserve,
            );

            switch (loopMode) {
              case VillainLoopMode.dont:
                useMemoized(() => animationController.forward(),
                    key != null ? [key] : []);
                break;
              case VillainLoopMode.repeat:
                useMemoized(() => animationController.repeat(),
                    key != null ? [key] : []);
                break;
              case VillainLoopMode.pingpong:
                useMemoized(() => animationController.repeat(reverse: true),
                    key != null ? [key] : []);
                break;
            }

            return AnimatedBuilder(
              key: key != null ? ValueKey(key) : null,
              animation: animationController,
              builder: (context, snapshot) {
                final range = FieldLerp(from, to, field)
                    .lerp(interpolationValue((Interval(
                  delay.inMilliseconds.toDouble() /
                      (inTime + delay).inMilliseconds.toDouble(),
                  1.0,
                  curve: curve ?? VillainApplicator.defaultCurve,
                ).transform)(animationController.value)));
                return applyOn(range) > child;
              },
            );
          },
        );
      });
}
