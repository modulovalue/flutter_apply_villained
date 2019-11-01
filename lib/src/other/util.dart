/// Tracks cumulatively added durations inside of a mutable object.
class ChoreographyDelayTracker {
  Duration _start;

  Duration _initStart;

  ChoreographyDelayTracker([this._start = Duration.zero])
      : this._initStart = _start;

  factory ChoreographyDelayTracker.ms(int ms) =>
      ChoreographyDelayTracker(Duration(milliseconds: ms));

  /// The the current duration before [add] was added to it.
  Duration getPre(Duration add) => _start += add;

  /// The the current duration after [add] was added to it.
  Duration getPreMS(int ms) => _start += Duration(milliseconds: ms);

  /// Reset the current duration.
  void reset() => _start = _initStart;
}
