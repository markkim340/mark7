import 'package:mark7/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip/$value';
  }

  static List<String> listPathsToUrls(List<String> values) {
    return values.map((e) => pathToUrl(e)).toList();
  }
}
