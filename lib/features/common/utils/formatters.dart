import 'package:intl/intl.dart';

class Formatters {
  // Format date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var i = (bytes.toString().length / 3).floor();
    return '${(bytes / (1024 ^ i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  // Format numbers
  static String formatNumber(double number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals);
  }

  static String formatCurrency(double amount, String currency) {
    final format = NumberFormat.simpleCurrency(name: currency);
    return format.format(amount);
  }

  static String formatPercentage(double value, {int decimals = 1}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }

  // Format dimensions
  static String formatDimension(double value, String unit) {
    return '${formatNumber(value)} $unit';
  }

  static String formatResolution(int width, int height) {
    return '${width}x$height';
  }

  // Format scientific notation
  static String formatScientific(double number, {int decimals = 2}) {
    return number.toStringAsExponential(decimals);
  }

  // Format duration
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Format file name
  static String formatFileName(String name, {int maxLength = 50}) {
    if (name.length <= maxLength) return name;
    final extension = name.substring(name.lastIndexOf('.'));
    final nameWithoutExt = name.substring(0, name.lastIndexOf('.'));
    final truncated = nameWithoutExt.substring(0, maxLength - extension.length - 3);
    return '$truncated...$extension';
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Format camelCase to readable text
  static String camelCaseToReadable(String text) {
    final result = text.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(1)}',
    );
    return capitalize(result.trim());
  }
}
