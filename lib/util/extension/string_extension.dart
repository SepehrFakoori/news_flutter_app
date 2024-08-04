extension DateTimeFormatter on String {
  String toCustomFormat() {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Format the DateTime object to the desired output format
    String formattedDate = "${dateTime.year.toString().padLeft(4, '0')}"
        ".${dateTime.month.toString().padLeft(2, '0')}"
        ".${dateTime.day.toString().padLeft(2, '0')}"
        " ${dateTime.hour.toString().padLeft(2, '0')}"
        ":${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedDate;
  }
}
