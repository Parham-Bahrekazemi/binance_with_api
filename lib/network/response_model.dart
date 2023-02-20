class ResponseModel<T> {
  late Status status;
  late T data;
  late String message;

  ResponseModel.loading(this.message) : status = Status.LOADING;
  ResponseModel.complete(this.data) : status = Status.COMPLETE;
  ResponseModel.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status : $status \n  Message : $message \n Data : $data';
  }
}

enum Status { LOADING, COMPLETE, ERROR }
