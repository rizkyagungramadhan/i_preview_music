/// Created by rizkyagungramadhan@gmail.com 
/// on 5/18/2022.


enum TimeLabelType {
  /// The time label on the right shows the total time.
  ///
  /// | -------O---------------- |
  /// | 01:23              05:00 |
  totalTime,

  /// The time label on the right shows the remaining time as a
  /// negative number.
  ///
  /// | -------O---------------- |
  /// | 01:23             -03:37 |
  remainingTime,
}
