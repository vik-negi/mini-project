import 'package:evika/models/user/post_model.dart';

abstract class CommonRepo {
  Future<List>? userLikedPost();
  Future<List<Comment>> getComments(String postId);
}
