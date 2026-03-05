class NetworkDataResponse<T> {
  late Status status;
  T? data;
  String message;
  
  NetworkDataResponse.idle()
      : status = Status.IDLE,
        message = "";

  NetworkDataResponse.loading(this.message) : status = Status.LOADING;

  NetworkDataResponse.completed(
    this.data, {
    this.message = "",
  }) : status = Status.COMPLETED;

  NetworkDataResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
  
}

// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR, IDLE }
