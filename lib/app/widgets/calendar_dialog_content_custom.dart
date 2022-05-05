// // ignore_for_file: non_constant_identifier_names, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:where_the_food/app/modules/register/logic.dart';
import 'package:where_the_food/app/utils/color.dart';

import 'drop_down_custom.dart';

class CustomCalendarDialogContent extends StatelessWidget {
  final logic = Get.find<RegisterLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<RegisterLogic>(
              builder: (logic) {
                return CustomDropdownButton2(
                    hint: DateFormat.MMMM().format(DateTime.now()).toString(),
                    dropdownItems: logic.allMonth,
                    buttonDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(245, 248, 249, 1),
                    ),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(245, 248, 249, 1),
                    ),
                    value: logic.monthDropdownValue,
                    onChanged: (value) => logic.onMonthSelected(value!),
                    offset: const Offset(0, -10));
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GetBuilder<RegisterLogic>(
              builder: (logic) {
                return CustomDropdownButton2(
                    hint: DateFormat('yyyy').format(DateTime.now()).toString(),
                    dropdownItems: logic.allYear,
                    buttonDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(245, 248, 249, 1),
                    ),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(245, 248, 249, 1),
                    ),
                    value: logic.yearDropdownValue.toString(),
                    onChanged: (value) =>
                        logic.onYearSelected(int.parse(value!)),
                    offset: const Offset(0, -10));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        GetBuilder<RegisterLogic>(
          builder: (logic) {
            return SfDateRangePicker(
              view: DateRangePickerView.month,
              controller: logic.dateController,
              headerHeight: 0,
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontSize: 16,
                ),
                todayTextStyle: GoogleFonts.comfortaa(
                  color: halfMainColor,
                  fontSize: 16,
                ),
              ),
              selectionTextStyle: GoogleFonts.comfortaa(
                color: Colors.white,
                fontSize: 16,
              ),
              todayHighlightColor: halfMainColor,
              selectionColor: halfMainColor,
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) => logic.onDateSelected(dateRangePickerSelectionChangedArgs),
              monthViewSettings:
                  const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
            );
          },
        ),
      ],
    );
  }
}
