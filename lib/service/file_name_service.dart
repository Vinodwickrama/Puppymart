final FileNameService fileNameService = FileNameService();

class FileNameService {
  static String getFileNameFromDateTime(DateTime dateTime, String uid) {
    String fileName = uid +
        '_' +
        dateTime.year.toString() +
        dateTime.month.toString().padLeft(2, '0') +
        dateTime.day.toString().padLeft(2, '0') +
        '_' +
        dateTime.hour.toString().padLeft(2, '0') +
        dateTime.minute.toString().padLeft(2, '0') +
        '_' +
        dateTime.second.toString().padLeft(2, '0') +
        dateTime.millisecond.toString().padLeft(3, '0');

    return fileName;
  }

  static String getPostIdFromDateTime(DateTime dateTime, String uid) {
    String fileName = 'P' +
        uid +
        '_' +
        dateTime.year.toString() +
        dateTime.month.toString().padLeft(2, '0') +
        dateTime.day.toString().padLeft(2, '0') +
        '_' +
        dateTime.hour.toString().padLeft(2, '0') +
        dateTime.minute.toString().padLeft(2, '0') +
        '_' +
        dateTime.second.toString().padLeft(2, '0') +
        dateTime.millisecond.toString().padLeft(3, '0');

    return fileName;
  }
}
