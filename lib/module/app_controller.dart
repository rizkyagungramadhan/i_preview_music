import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/style/app_dimen.dart';
import 'package:i_preview_music/style/app_text_style.dart';
import 'package:i_preview_music/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

mixin AppController {
  /// Doc : Used for forcing connectionState to online. Wrap it inside try catch block.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:19.
  forceToConnected([RxBool? isConnectionAvailable]) async {
    final bool isConnected = await checkConnection();
    isConnectionAvailable?.value = isConnected;
    if (!isConnected) {
      throw AppException("No connection available");
    }
  }

  Future<bool> checkConnection() async => await Connectivity()
      .checkConnectivity()
      .then((result) => result != ConnectivityResult.none);

  /// Doc : Avoid using with navigating to new page. Bcs snackbar loose his context. Use [showToast] instead.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:19.
  showInformationSnackbar(dynamic message) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CupertinoColors.systemGrey6,
        titleText: Center(
          child: Text(
            "Information",
            maxLines: 1,
            style: AppTextStyle.light(),
          ),
        ),
        messageText: Center(
          child: Text(
            message.toString(),
            style: AppTextStyle.regular(),
          ),
        ),
        margin: const EdgeInsets.only(bottom: AppDimen.paddingLarge));
  }

  showToast(message) => Fluttertoast.showToast(msg: message.toString());

  /// Doc : Listen into changed Keyboard visibility state.
  /// [isKeyboardVisible] used for manage UI from [KeyboardVisibilityController] state which will be stored into [RxBool] observable object.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:20.
  attachKeyboardListener(
      KeyboardVisibilityController keyboardVisibilityController,
      Rx<bool> isKeyboardVisible) {
    keyboardVisibilityController.onChange.listen((isVisible) {
      isKeyboardVisible.value = isVisible;
    });
  }
}
