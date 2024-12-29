import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import '../../exports.dart';

class PermissionContext {
  late BuildContext context;
  late Widget dialog;
  PermissionContext();
  Future<bool?> getDialogPermission() => showDialog(
        context: context,
        builder: (context) => dialog,
      );
  setContext({required BuildContext context, required Widget dialog}) {
    this.dialog = dialog;
    this.context = context;
  }
}

class PermissionManager {
  late PermissionContext permissionContext;
  late PermissionRequest permissionRequest;
  PermissionManager() {
    permissionRequest = PermissionRequest();
    permissionContext = PermissionContext();
  }
  setPermissionTypeAndContext(
      {required BuildContext context,
      required int type,
      required Widget dialog}) {
    permissionContext.setContext(context: context, dialog: dialog);
    permissionRequest.setPermissionType(type);
  }

  // Future<bool> getPermission() async {
  //   if (permissionRequest.type == Permission.location.value) {
  //     bool isServiceEnabled = await Permission.location.serviceStatus.isEnabled;
  //     if (isServiceEnabled.isTrue) {
  //       return requestPermission();
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return requestPermission();
  //   }
  // }

  Future<bool> requestPermission() async {
    PermissionStatus status = await permissionRequest.checkStatus();
    bool isGranted = await permissionRequest.isPermissionGranted(status);
    if (isGranted.isFalse) {
      bool? isAllowed = await permissionContext.getDialogPermission();
      log("permission status is $status");
      if (isAllowed.isNotNullAndIsTrue) {
        if (status == PermissionStatus.permanentlyDenied) {
          isGranted = await permissionRequest.permanentDeniedHandle();
        } else {
          isGranted = await permissionRequest.isPermissionGranted(
            await permissionRequest.requestPermission(),
          );
        }
      }
    }

    return isGranted;
  }
}

class PermissionRequest extends WidgetsBindingObserver {
  late int type;
  bool isClosed = false;

  PermissionRequest();
  setPermissionType(int type) => this.type = type;
  Future<bool> permanentDeniedHandle() async {
    bool isOpened = await openAppSettings();
    if (isOpened.isTrue) {
      WidgetsBinding.instance
          .addObserver(this); //this sets WidgetsBindingObserver
      for (int counter = 30; counter >= 0; counter--) {
        await Future.delayed(1.milliseconds, () {});
        if (counter == 0 && isClosed.isFalse) {
          counter = 30;
        } else if (isClosed.isTrue) {
          break;
        }
      }
      return await isPermissionGranted(await checkStatus());
    }
    return false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("state ${state.name}");
    if (state == AppLifecycleState.resumed) {
      isClosed = true;
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<bool> isPermissionGranted(PermissionStatus status) async =>
      status.isGranted;
  Future<PermissionStatus> checkStatus() => Permission.byValue(type).status;
  Future<PermissionStatus> requestPermission() =>
      Permission.byValue(type).request();
}
