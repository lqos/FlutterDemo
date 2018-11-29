class RegUtils {
  // 检查手机号
  static bool checkPhone(String value) {
    RegExp exp = new RegExp(
        r"(13[0-9]|14[5,7]|15[0-9]|17[0-9]|18[0-9]|19[0-9])[0-9]{8}");
    return exp.hasMatch(value);
  }
}
