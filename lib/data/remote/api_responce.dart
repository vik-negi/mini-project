class ApiResponce<T> {
  Status? status;
  final String? message;
  final T? data;

  ApiResponce(this.status, this.message, this.data);
  ApiResponce.loading()
      : status = Status.loading,
        message = 'Loading',
        data = null;

  ApiResponce.completed(this.data)
      : status = Status.completed,
        message = 'Completed';

  ApiResponce.error(this.message)
      : status = Status.error,
        data = null;

  @override
  String toString() {
    return 'Status: $status, Message: $message, Data: $data';
  }
}

enum Status { loading, completed, error }
