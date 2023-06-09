// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names

import 'package:easy_localization/easy_localization.dart';

getFormatedDate(_date) {
  var inputFormat = DateFormat('dd-MM-yyyy');
  var inputDate = inputFormat.parse(_date);
  var outputFormat = DateFormat('dd MMM yyyy');
  return outputFormat.format(inputDate);
}

final numberFormat = NumberFormat("##,##0.00", "en_US");
