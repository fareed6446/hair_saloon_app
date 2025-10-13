import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
  }

  static String formatDateShort(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  static String formatTimeShort(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatDateTimeShort(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
  }

  static String formatRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays > 7) {
      return formatDate(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} from now';
    } else if (difference.inDays < 0 && difference.inDays > -7) {
      return '${-difference.inDays} day${-difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < -7) {
      return formatDate(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} from now';
    } else if (difference.inHours < 0) {
      return '${-difference.inHours} hour${-difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} from now';
    } else if (difference.inMinutes < 0) {
      return '${-difference.inMinutes} minute${-difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  static String formatDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  static String formatBookingDate(DateTime date) {
    if (isToday(date)) {
      return 'Today, ${formatTime(date)}';
    } else if (isTomorrow(date)) {
      return 'Tomorrow, ${formatTime(date)}';
    } else {
      return formatDateTime(date);
    }
  }
}
