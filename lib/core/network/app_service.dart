import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../exports.dart';
import '../enums.dart';
import '../helpers/app_helper.dart';
import '../utils/debug_prints.dart';
import '../widgets/custom_dialog.dart';

class AppService {
  /// Private constructor
  AppService._();
  Logger logger = Logger();

  /// Factory method that reuse same instance automatically
  static final AppService _instance = AppService._();
  factory AppService() => _instance;

  Future showCustomDialog({
    String? message,
    Widget? child,
    bool isAlert = true,
    AlertTypes dialogType = AlertTypes.loading,
    bool dismissible = false,
  }) =>
      showDialog(
        context: getContext,
        barrierDismissible: dismissible,
        builder: (context) {
          return isAlert
              ? AlertDialog(
                  content: child,
                )
              : CustomDialog(
                  message: message,
                  dialogType: dialogType,
                );
        },
      );
  Future showCustomDialogWithTimer({
    String? message,
    bool dismissible = false,
    AlertTypes dialogType = AlertTypes.loading,
    DialogTimingTypes dialogTimingType = DialogTimingTypes.long,
    void Function()? onTimeOut,
  }) async {
    if (_isThereCurrentDialogShowing(getContext).isTrue) {
      pop();
    }
    showCustomDialog(
        isAlert: false,
        message: message,
        dialogType: dialogType,
        dismissible: dismissible);
    Timer(
      Duration(
        milliseconds: dialogTimingType == DialogTimingTypes.long
            ? AppConstants.dialogLongDuration
            : AppConstants.dialogShortDuration,
      ),
      () {
        pop();
        if (onTimeOut.isNotNull) {
          onTimeOut!();
        }
      },
    );
  }

  /* check whether Alert Dialog is open */
  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  /*hide keypad if it is shown*/
  requestFocus(FocusNode focusNode) =>
      FocusScope.of(getContext).requestFocus(focusNode);
  T getBlocData<T extends StateStreamableSource<Object?>>() =>
      BlocProvider.of<T>(getContext);
  // showDateTimeDialog(
  //         {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) =>
  //     showDatePicker(
  //       context: getContext,
  //       builder: (context, child) => Theme(
  //         data: ThemeData.light().copyWith(
  //           dialogBackgroundColor: AppColors.white,
  //           colorScheme: const ColorScheme.light(
  //             primary: AppColors.primaryColor, //dialog header background color
  //             onPrimary: AppColors.white, //selected text color and border
  //           ),
  //         ),
  //         child: child!,
  //       ),
  //       locale:
  //           // getBlocData<LanguageCubit>().isEn
  //           //     ? AppConstants.enLocale
  //           //     :
  //           AppLocalizationsConstants().arLocale,
  //       initialDate: initialDate.isNotNull ? initialDate! : DateTime.now(),
  //       firstDate: firstDate.isNotNull ? firstDate! : DateTime.now(),
  //       lastDate: lastDate.isNotNull
  //           ? lastDate!
  //           : DateTime(DateTime.now().year + AppConstants.maxYears),
  //     );

  /// show child widget in dialog
  Future<T?> showInDialog<T>({
    String? title,
    Widget? child,
    Widget? Function(BuildContext)? builder,
    ShapeBorder? shape,
    TextStyle? titleTextStyle,
    EdgeInsetsGeometry? contentPadding,
    //bool scrollable = false,
    EdgeInsetsGeometry? titlePadding,
    Color? backgroundColor,
    DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
    double? elevation,
    Color? barrierColor,
    //EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    List<Widget>? actions,
    bool barrierDismissible = true,
    bool hideSoftKeyboard = true,
    Duration? transitionDuration,
    Curve curve = Curves.easeInBack,
  }) async {
    if (hideSoftKeyboard) hideKeyboard;

    return await showGeneralDialog<T>(
      context: getContext,
      barrierColor: barrierColor ?? Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      transitionDuration: transitionDuration ?? 400.milliseconds,
      transitionBuilder: (_, animation, secondaryAnimation, c) {
        return dialogAnimatedWrapperWidget(
          animation: animation,
          dialogAnimation: dialogAnimation,
          curve: curve,
          child: AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            // ignore: no_wildcard_variable_uses
            content: builder != null ? builder.call(_) : child,
            shape: shape, titlePadding: titlePadding,
            title: Text(title!),
            titleTextStyle: titleTextStyle,
            contentPadding: contentPadding ??
                const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            //scrollable: scrollable,
            backgroundColor: backgroundColor,
            elevation: elevation ?? AppConstants.defaultElevation,
            //insetPadding: insetPadding,
            actions: actions,
            icon: GestureDetector(
              onTap: pop,
              child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(Icons.close)),
            ),
          ),
        );
      },
    );
  }

  showToast({required String message, required AlertTypes alertType}) {
    Fluttertoast.showToast(
/*
      child: Container(
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(19)),
        padding: getPadding(all: 17),
        child: Row(
          children: [
            Image.asset(
              AppAssets().tripiaAppIcon,
              height: 20.h,
              width: 20.w,
            ),
            10.hs,
            Expanded(
              child: AutoSizeText(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                style: getSemiboldTextStyle(fontSize: 12, color: AppColors.white),
              ),
            ),
            if (alertType == AlertTypes.warning)
              const Icon(
                Icons.error,
                size: 20,
                color: AppColors.white,
              ),
            if (alertType == AlertTypes.error)
              const Icon(
                Icons.clear,
                size: 20,
                color: AppColors.white,
              ),
          ],
        ),
      ),
*/
      gravity: ToastGravity.BOTTOM,
      msg: message,
    );
  }
}
