class DataResult<T> {
  bool result;
  T data;
  String message;

  static create<VH>(bool result, {VH data, String message}) {
    DataResult dataResult = new DataResult<VH>();
    dataResult.result = result;
    dataResult.data = data;
    dataResult.message = message;
    return dataResult;
  }
}
