import 'package:intl/intl.dart';

class CommonUtils {
  static String getFormattedDate(String? inputDate) {
    // Parse the input date string
    DateTime date = DateFormat('MM/dd/yyyy').parse(inputDate ?? '');

    // Get today's and tomorrow's dates
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    // Remove time part for comparison
    DateTime onlyDate = DateTime(date.year, date.month, date.day);
    DateTime onlyToday = DateTime(today.year, today.month, today.day);
    DateTime onlyTomorrow = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
    );

    // Switch case logic
    if (onlyDate == onlyToday) {
      return "Today";
    } else if (onlyDate == onlyTomorrow) {
      return "Tomorrow";
    } else {
      return inputDate ?? ""; // Return the original date string if no match
    }
  }

  static String formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMM dd, yyyy").format(parsedDate);
    } catch (e) {
      return date; // Return the original date string if parsing fails
    }
  }

  static bool isExpired(String dateString) {
    try {
      DateFormat format = DateFormat(
        "MM/dd/yyyy",
      ); // Define the expected format
      DateTime inputDate = format.parse(
        dateString,
      ); // Convert String to DateTime
      DateTime today = DateTime.now();

      // Compare only the date, ignoring the time part
      DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);
      DateTime inputWithoutTime = DateTime(
        inputDate.year,
        inputDate.month,
        inputDate.day,
      );

      return inputWithoutTime.isBefore(todayWithoutTime);
    } catch (e) {
      return false;
    }
  }
}
