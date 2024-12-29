import '../../../../exports.dart';

Widget buildDropdown({
  required BuildContext context,
  required String? value,
  required String hint,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Flexible(
    child: Container(
      padding: 8.ph,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(color: AppColors.transparent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: AppColors.lightPurple,
          value: value,
          hint: Text(
            hint,
            style: getRegularTextStyle(color: AppColors.white, fontSize: 14.0),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: getRegularTextStyle(
                          color: AppColors.white, fontSize: 14.0),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.white),
        ),
      ),
    ),
  );
}
