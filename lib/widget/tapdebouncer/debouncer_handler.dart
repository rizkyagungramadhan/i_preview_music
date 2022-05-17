import 'dart:async';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


/// Doc : Single tap debouncer.
/// @author rizkyagungramadhan@gmail.com on 18-May-2022, Wed, 01:18.
class DebouncerHandler {
  DebouncerHandler() : _busyController = StreamController<bool>()..add(false);

  final StreamController<bool> _busyController;

  /// Busy state stream
  Stream<bool> get busyStream => _busyController.stream;

  /// Dispose resources
  void dispose() {
    _busyController.close();
  }

  /// Process onTap
  Future<void> onTap(Future<void> Function() onTap) async {
    try {
      if (!_busyController.isClosed) {
        _busyController.add(true);
      }

      await onTap();
    } on Exception catch (_) {
      rethrow;
    } finally {
      if (!_busyController.isClosed) {
        _busyController.add(false);
      }
    }
  }
}
