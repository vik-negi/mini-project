class PostApiResponce<T> {
  Status? status;
  final String? message;
  final List<T>? data;

  PostApiResponce(this.status, this.message, this.data);
  PostApiResponce.loading()
      : status = Status.loading,
        message = 'Loading',
        data = null;

  PostApiResponce.completed(this.data)
      : status = Status.completed,
        message = 'Completed';

  PostApiResponce.error(this.message)
      : status = Status.error,
        data = null;

  @override
  String toString() {
    return 'Status: $status, Message: $message, Data: $data';
  }
}

enum Status { loading, completed, error }
