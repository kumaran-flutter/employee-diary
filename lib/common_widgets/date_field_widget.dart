import 'package:employee_diary/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'common_widgets.dart';

class DateFieldWidget extends StatelessWidget {
  const DateFieldWidget({
    super.key,
    this.controller,
    this.isEndDate = false,
    this.validator,
  });
  final TextEditingController? controller;
  final bool isEndDate;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      errorStyle: const TextStyle(height: 0.01),
      validator: validator,
      controller: controller,
      readOnly: true,
      hintText: "No Date",
      prefixIcon: const Icon(
        Icons.event_outlined,
        color: AppColors.twitterBlue,
      ),
      onTap: () async {
        showDateSelectionDialog(context, controller, isEndDate);
      },
    );
  }
}

class DateSelectionDialogContent extends StatefulWidget {
  const DateSelectionDialogContent({
    super.key,
    this.controller,
    required this.isEndDate,
  });
  final TextEditingController? controller;
  final bool isEndDate;

  @override
  State<DateSelectionDialogContent> createState() =>
      _DateSelectionDialogContentState();
}

class _DateSelectionDialogContentState
    extends State<DateSelectionDialogContent> {
  DateTime? selectedDate = DateTime.now();

  DateTime get nextMonday {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (8 - now.weekday) % 7));
  }

  DateTime get nextTuesday {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (9 - now.weekday) % 7));
  }

  DateTime get afterOneWeek => DateTime.now().add(const Duration(days: 7));

  String formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  @override
  initState() {
    super.initState();
    selectedDate =
        widget.controller != null &&
                widget.controller!.text.isNotEmpty &&
                widget.controller!.text != "No date"
            ? DateFormat('MM/dd/yyyy').parse(widget.controller!.text)
            : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 16,
            children: [
              if (widget.isEndDate) _dateButton("No date", null),
              _dateButton("Today", DateTime.now()),
              if (!widget.isEndDate) _dateButton("Next Monday", nextMonday),
            ],
          ),

          if (!widget.isEndDate) ...[
            const SizedBox(height: 8),
            Row(
              spacing: 16,
              children: [
                _dateButton("Next Tuesday", nextTuesday),
                _dateButton("After 1 week", afterOneWeek),
              ],
            ),
            const SizedBox(height: 16),
          ],

          TableCalendar(
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
              ),
              weekendStyle: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.twitterBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ), // Text color
                  ),
                );
              },

              todayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.twitterBlue, width: 2),
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(
                      color: AppColors.twitterBlue,
                      fontWeight: FontWeight.w600,
                    ), // Text color
                  ),
                );
              },
            ),
            focusedDay: selectedDate ?? DateTime.now(),
            firstDay:
                widget.isEndDate ? DateTime.now() : DateTime.utc(2000, 1, 1),

            lastDay: DateTime.utc(2100, 12, 31),
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              leftChevronIcon: const Icon(
                Icons.arrow_left,
                size: 35,
                color: AppColors.grayText,
              ),
              rightChevronIcon: const Icon(
                Icons.arrow_right,
                size: 35,
                color: AppColors.grayText,
              ),
              formatButtonVisible: false,
              titleTextStyle: PrimaryTextStyle.primaryStyle2,

              leftChevronMargin: const EdgeInsets.only(left: 24),
              rightChevronMargin: const EdgeInsets.only(right: 24),
              titleCentered: true,
            ),
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selectedDay, _) {
              setState(() {
                selectedDate = selectedDay;
              });
            },
          ),

          const SizedBox(height: 16),

          Divider(color: AppColors.borderGray, thickness: 1),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.event_outlined, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        selectedDate != null
                            ? DateFormat('d MMM yyyy').format(selectedDate!)
                            : "No date",
                        style: PrimaryTextStyle.primaryStyle5,
                      ),
                    ],
                  ),
                ),
                ActionButton(
                  onCancelPressed: () {
                    Navigator.pop(context);
                  },
                  onSavePressed: () {
                    //Update the controller with the selected date
                    if (widget.controller != null && selectedDate != null) {
                      widget.controller!.text = DateFormat(
                        'MM/dd/yyyy',
                      ).format(selectedDate!);
                    } else {
                      widget.controller!.text = "No date";
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateButton(String text, DateTime? date) {
    bool isSelected =
        date != null && selectedDate != null
            ? formatDate(date) == formatDate(selectedDate!)
            : false; // Compare dates

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDate = date;
          });
        },
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(
            isSelected ? AppColors.twitterBlue : AppColors.lightBlue,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.twitterBlue,
          ),
        ),
      ),
    );
  }
}

void showDateSelectionDialog(
  BuildContext context,
  TextEditingController? controller,
  bool isEndDate,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: DateSelectionDialogContent(
          controller: controller,
          isEndDate: isEndDate,
        ),
      );
    },
  );
}
