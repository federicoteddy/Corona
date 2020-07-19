class NumberUtil {
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  String setDecimalFormat(int value) {
    return value.toString().replaceAllMapped(reg, mathFunc);
  }
}
