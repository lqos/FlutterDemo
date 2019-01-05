///数据封装
class DataResult<T> {
  ///是否成功
  bool result;

  ///数据存放
  T data;

  ///信息
  String message;

  static create<VH>(bool result, {VH data, String message}) {
    DataResult dataResult = new DataResult<VH>();
    dataResult.result = result;
    dataResult.data = data;
    dataResult.message = message;
    return dataResult;
  }
}
