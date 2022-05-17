import 'package:intl/intl.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


extension DateTimeExt on DateTime {
  /// Doc : Covert [DateTime] toString with format [dd-MMM-yyyy].
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:26.
  String toCompactDate([String dateSeparator = " "]) {
    final format = DateFormat("dd${dateSeparator}MMM${dateSeparator}yyyy");
    return format.format(this);
  }
}